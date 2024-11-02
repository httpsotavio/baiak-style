/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2019  Mark Samman <mark.samman@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "mounts.h"
#include "tools.h"

#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

bool Mounts::reload()
{
	mounts.clear();
	return loadFromXml();
}

bool Mounts::parseMountNode(xmlNodePtr p)
{
	if (xmlStrcmp(p->name, (const xmlChar*)"mount"))
		return false;

	int32_t mountId = 0;
	int32_t clientId = -1;
	std::string name = "";
	int32_t speed = 0;
	bool premium = false;

	int32_t intValue;
	std::string strValue;

	if (!readXMLInteger(p, "id", intValue))
	{
		std::cerr << "[Error - Mounts::parseMountNode] Missing mount id, skipping" << std::endl;
		return false;
	}
	mountId = intValue;

	if (mountId == 0) {
		std::cerr << "[Warning - Mounts::parseMountNode] invalid mountId: " << mountId << std::endl;
		return false;
	}


	for (MountVec::iterator it = mounts.begin(); it != mounts.end(); ++it)
	{
		if ((*it).id == mountId) {
			std::cerr << "[Warning - Mounts::parseMountNode] Duplicated mount id " << mountId << std::endl;
			return false;
		}
	}

	if (readXMLInteger(p, "clientid", intValue))
		clientId = intValue;

	if (clientId == -1)
		std::cerr << "[Warning - Mounts::parseMountNode] invalid clientid: " << clientId << std::endl;

	if (readXMLString(p, "name", strValue))
		name = strValue;

	if (readXMLInteger(p, "speed", intValue))
		speed = intValue;

	if (readXMLString(p, "premium", strValue))
		premium = booleanString(strValue);



	mounts.push_back(Mount(mountId, clientId, name, speed, premium));
	return true;
}


bool Mounts::loadFromXml()
{
	xmlDocPtr doc = xmlParseFile(getFilePath(FILE_TYPE_XML, "mounts.xml").c_str());
	if (!doc)
	{
		std::cerr << "[Warning - Mounts::loadFromXml] Cannot load mounts file, using defaults." << std::endl;
		std::cerr << getLastXMLError() << std::endl;
		return false;
	}

	xmlNodePtr root = xmlDocGetRootElement(doc);
	if (xmlStrcmp(root->name, (const xmlChar*)"mounts"))
	{
		std::cerr << "[Error - Mounts::loadFromXml] Malformed mounts file." << std::endl;
		xmlFreeDoc(doc);
		return false;
	}

	for (xmlNodePtr p = root->children; p; p = p->next)
		parseMountNode(p);

	xmlFreeDoc(doc);
	return true;
}

Mount* Mounts::getMountByID(uint8_t id)
{
	auto it = std::find_if(mounts.begin(), mounts.end(), [id](const Mount& mount) {
		return mount.id == id;
		});

	return it != mounts.end() ? &*it : nullptr;
}

Mount* Mounts::getMountByName(const std::string& name) {
	auto mountName = name.c_str();
	for (auto& it : mounts) {
		if (strcasecmp(mountName, it.name.c_str()) == 0) {
			return &it;
		}
	}

	return nullptr;
}

Mount* Mounts::getMountByClientID(uint16_t clientId)
{
	auto it = std::find_if(mounts.begin(), mounts.end(), [clientId](const Mount& mount) {
		return mount.clientId == clientId;
		});

	return it != mounts.end() ? &*it : nullptr;
}