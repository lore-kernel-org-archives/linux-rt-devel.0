Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794581819;
	b=jlO7r2zgKosEjnIbuWTDmn010QBGjvLqd2I6VxOG0tTqtXFsZU5MYFDDb4MANnbWbHLw
	 sMtBIu4rzW85NPsaeRr7LEAm17K9CALB0DeKo5gYUouXwEo2bZiucMzGnijfZT8utJiIy
	 uwZcMOTRjfH5MVwLeBVCqZZQZ7uL+JB+jqQdRMjq5nzpfjmsk0JtIuTXjNLdlzdRsHxOp
	 m0L5uNUl/lcX/888a1M/Sg+KSG5+pAvrYv3aFoQ8XXfrNtWprboEBAzG4B4Jp6RjDCyon
	 iteeXGDWaDnpBumJKev9zRilIzoajxkGAKYSgJI6Lm6OgHj69c3ZgXxLejvYYN/PgcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581819;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=k/kbIJ/lfW9zMp5wHpTZ4D6OCWe6rRe5y2Zi3t+GWGk=;
	b=YGt22eZnnehlxSrRQ13XmKvoFAYSeCDw9dQgeRrEfR3kz4qvK3FMZrktVI/uzV+X63VK
	 Rzl2fDFIW2kPtcNYM3vXAl5+ydvQL5A96Ed+zjZmyzgy5K/tgD0F8CfojPesfqezTi/yr
	 uCPCZy8vvyMGqk6ZCSxBTBneIpeIjWNYc1XVOqNXCOe6sZaUuZP/9nQwn/ltWZBt/k7yF
	 /BpQ0nl8mG/TNOpyl1qxyQmJCvwiTYjJ8xAEoyQTx4SpW7PTrHGfwJa1iRaIqj/LJ6zic
	 lreNL6wZ1pEHnpaUxO2gFR7WiXo/ETB0XbwzVs0xZOgMhUUvxlbbFqUollBY5A1upvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PywNnW58;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.10
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673C606A327
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 14:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4673C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PywNnW58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu8fe9Ac0nJ3AyILNnv2CrmXzoMr1hxMT4XHDNoaGs/iHB+LKudJ7wlnI2cKTq0wHIST1cdpKhB8WHyeAqgjzTxmcvvW7F58yx45istOjXkNNIn47Lls9uioipA1aFUxDVYGDvTpIEByAPVWk9dhxqZ/Mldzz4avYdwTX0FIwed7JGxHwRp3XIEpI2qxBeNM9SpdNuuLHQ+6ko0hTsTkBTIwn4Sojcs39RVocR7WA5WxDr+fom8neiZjbx0P7WUQGKtint/PZD0c0jVgLv09MfbrmkCDE4UEKTd1IqugvZj4jPo0nNWgChs0hcb3oKdtJlz7bTLEBhxPDZ86/78Otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/kbIJ/lfW9zMp5wHpTZ4D6OCWe6rRe5y2Zi3t+GWGk=;
 b=tPlSrau2ssPO7iGxk8SDx4Wl8psEFZDpPcKDpsyUdt8ev6KcnxJmU01CxoM+FOqeE4yBpvgcsZQx6dm1tuYvfbewot1w4ziTFYgFv6wgBlenwGfOAv/XNRLR4LY6I16Cdlyp6bdSIFQIpgki0FKxyaBxJNNXoGYAib/i9ZWaIAMN9WM4UvGyEMgzgVZbmC1snSSDCxhJNIubq3JSZcMxH8hcackmGXGwzEbmm1N9MLPT+J1wa7AHD96cFkggN1lIPApkWw+WWLYlHAlCDLBPxg0yFoBfvD+JPK7eLsKh5pzdkhS+pIJNnxQa/7yPlK483e7aPkcBHhOqwqEZDNBWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/kbIJ/lfW9zMp5wHpTZ4D6OCWe6rRe5y2Zi3t+GWGk=;
 b=PywNnW584lXOrBn91suNF1GoPe2LFokkoq7fAlQnxzhwl9ulbY325LXqV/GBuT1v01p3C0SulfRtLnY1zE+vWc2i8JuOWXWoMecXFhYEANHsXa/2v+L4TOihUuC1qXBWHhRtmwxq/kvMcKI4QQE4uBtMG3Ds+zeWwsSr6JWTJrk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by CH3PR12MB463434.namprd12.prod.outlook.com (2603:10b6:610:39f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:56:51 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 14:56:51 +0000
Message-ID: <4254be1a-f80e-4389-b04d-9fd10c1b77b7@amd.com>
Date: Fri, 13 Nov 2026 20:26:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/8] dt-bindings: net: add Xilinx TSN Endpoint
 Ethernet MAC
To: Andrew Lunn <andrew@lunn.ch>, Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
 git@amd.com, neelisrinivas18@gmail.com
References: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
 <20261113-patches_v2_external-v4-1-56bb26f042a4@amd.com>
 <13864fbe-6cd1-4d70-afee-bd3d3be163f3@lunn.ch>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <13864fbe-6cd1-4d70-afee-bd3d3be163f3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0286.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::12) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|CH3PR12MB463434:EE_
X-MS-Office365-Filtering-Correlation-Id: f025e21f-920f-4d8b-543e-08df41965994
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006|10067099003|4143699003|261102123227099003|261026121527099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	M/Pt4pytU2fcMhsVRWfhOMenKLIcwiWG3HKqEWHBplego0zJixYHSeB/u/aUL5M5zkw10zAQI02wuQ2GKhZPflR1hx7cmxBHJlQHy9WUmQj7HxV4B85lF8sj+UrCDh/Sfitc3uxFytEKSOI27s4xZ03AP9LGXv4NvK77/hqgHmMw2f14GEOujr2iDguW6MoaBEbmFsqiyioqbR+7kLAptPHJjM71vmqceOLBmmHC5E2o2m6f1/grElAWCLXIocjmRdCM4gBkNfDTa8qARsOYFdS0ZglxrHZVqQ/vEQv//zgkBqHLV65EtBBTyoQnELOtfb8RM8CiQ7UwBuLrDfrMV55ukKQY1Fa5EPOPPLuU55VU22nhwwuENGuuOBuBfDqKZZDFBkFbz9fMZRI/VttGhZiWPn50/JcmuQEY9CqJk36yxPIJ+uaqwG/Yji2XBYEToXvJt6ytbC7ixDG8bJskBqoRVHwErvrvHFDWRUamsc7n8wHov9K17iROC/4SN/+PueTCPA7Bqrse4XagIlvdEX/8jqNjggCbxzaGY8+q+gJZC0l3TDZ2PnQGGGZteLqd8MX+xgSyHhdDjRFLz3+AgFTDSukodIxREFzusRsloA4DYSYtq7ZWlFQ1WhACjtrd2eendp7jGfd1jODh9M5SamQAf9WZUrh/1Q0Kcnh/WIY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVArZEE1Q2lZYXFJcGdSeVBQUHFQVUkyQ0FHckZyc3VtRUlaaklKWGUwZkd3?=
 =?utf-8?B?Y0R0R2ZhUzVsSW1zanUxazhPRHlLVzlFY2JoeGFmZVEyVGN4Z2NJZ2hQcnk0?=
 =?utf-8?B?SnpZYzdiSnBQTXo4NXJVWEs0eC9oSGw1eVROdjFDODVRU1pWc0FLM0NtNkpu?=
 =?utf-8?B?di9VSllCWkM0Z09xc0pyTWY3dG9yTmZKb2NkamdoM0tNWk9zbkN0NzA0Uk9t?=
 =?utf-8?B?MW94dXV0c1BwdHYzZ2Y3YlM3b2ROODRqd2FnTXBqN1pCVXg3U3hmaVpRVThL?=
 =?utf-8?B?QllxL3VnWE1HZlg1K0FFaThOamdsNVN1Yk1rcmxRbjZhc1F1anBFMlBUN2RW?=
 =?utf-8?B?NmF0Q2szR3NTTFpCTUg4L1VmQ0Nidy9odFdDZ3JKdU9kV3VmSkM0MHhYL05D?=
 =?utf-8?B?ME5zQjhxTUNhVXdING14ZTFOU2xHVVRxUDhRK2lDNG9wTTBJbEh3eVFJVWJp?=
 =?utf-8?B?SkEraDNYcDhyMHR3YnlzUk5Fdm1TYzNZSXpmazVLSExBbmNaWWRFNXcxY21B?=
 =?utf-8?B?aEhQb1lJQ3U5QVljQ3VUU1AwRyt0REVES3h1eTlLYXkySjAveEZMeHFYaUpX?=
 =?utf-8?B?RGMrMC9YYVhJTFdhdVQwZ3FZZHk1TThaRkFNVGxjMENxbjNaN2YwMG9ZcVVG?=
 =?utf-8?B?NWRoR2pZRWZtaUpGbm1OS3VQbHBVQkJmMWFaZllVOGtCeFRPUFhjNWcrM0Jk?=
 =?utf-8?B?ck9WVjZoWFJ2cVdQUjNvTFVjNWlLaHlBYTV5TUpocm1qRlVqT2dXTFJlTFMv?=
 =?utf-8?B?UzJwKzl5bWVidmxSKzd4bVBhb29XZVV1eWVuNEY4TnhUY0YyODF4NWsycHFR?=
 =?utf-8?B?dkpFZWNkbWlBVWNjczJoZVovVFJZbUNVclpwcWVkeFlLb3VxR2dyNGI0bXZF?=
 =?utf-8?B?RzhJbFVaYmg1UzU2OUFsSTVaQnY3TVk4eS9qR0NjRHhFTU5reEY0NlViU0NS?=
 =?utf-8?B?N3NDejlvWVordlNYdHZFdTl0SzZhOHhpUHdxYmZmaUlTeWFBS0ExRHc1dE00?=
 =?utf-8?B?dGJPOGxhTFVaam01a3BTRG9vNXl1Nm9pQTlreVkyenA2TVg2Z3M4SmtRTXlF?=
 =?utf-8?B?VVgvbWIvUkxWVDJINkQweUVVY0tXSHlZS1kyUlB4Yng5KzQzSHFScGs5aldY?=
 =?utf-8?B?MlRKZWlualo0dlJMMEt3ODUxUFRaNGQ0bnVScnhaUW1kdnlOTDF3Z2dPblNo?=
 =?utf-8?B?RHJubklvc2pIdzY5UmdKVmRYUGZOamlIUW5FTGtONVYzTFBDbm9SdS9lbGdI?=
 =?utf-8?B?SW93QjJWL2UvNGlVNEg0elFrRW1wU0NSdit5dnVlRU1GVUl0VXVxemE0UEFv?=
 =?utf-8?B?MnhkZWdEcSthYU1kMzFoZ1UwZGYwcXVISHpYZDZaUDl2am9EbGZtVXAyZDds?=
 =?utf-8?B?cU5VenFUbUlVNHlJcHV6a0NBMHllQ3M2ZmhMSHlUUm1QekxzdVM0WXcvSlps?=
 =?utf-8?B?dzFOdzJad3d1YkVEQkNFZS9WWkxhYllGaGtDR2ZIdDU3cFBlMHhscWJOd0x3?=
 =?utf-8?B?OVpKUnJXejQ3a2J5cmdGeTVyOW5tQnVGMkF4VTJUZEhQQTNLcHllQUJjS09m?=
 =?utf-8?B?MXE2VUpocnJlcFV5VCsyMWtmbGN5eXdOR041QTBQTFZLdC9FeWJXallSTm1j?=
 =?utf-8?B?Q2dSNmc3N3VJOTNJYURIUUdzL1doSklhWGIwcUFDN1lOZHJ0eGxOMmFVRGFx?=
 =?utf-8?B?MGtCbTl1bnJ0eU16SG9jdFhlMGZKeWNWcWZkUWwxQnJkQ05DOE8waGd2Sk1u?=
 =?utf-8?B?VkprUUJkSmpnY0hUaVZiZ2pZZStucFFWbHFCd3hjMEh3TWZsM2w2eHo5RTZR?=
 =?utf-8?B?K1BrYTJMQ25ZMVpNNDJpdjlHZzIyMTY3aUFOb3A2UGlTQ2l4eU0wT3dKbzBF?=
 =?utf-8?B?cFNsWjViOEhyb3F0UWdOdkZjTUlONXhqS0xWRUJESjJmczF6SEN3UGkveGpD?=
 =?utf-8?B?enFhaGVwUEE3VHlsallVV3Baa2ZKYTRqTWJBSU1vczdSQXZUcWx1UklnOFox?=
 =?utf-8?B?Q0FjcnVlRjQwKzhjU2JDb0ZoZVpxbGpCM01tSkxLdXdxWlBFRXBETHFUVjVT?=
 =?utf-8?B?cVJ1TmllUW4xMmtEbmNjbTlCQ3huVDJmb25vVXE1bVdWRy90dXhGYUxLcFBz?=
 =?utf-8?B?bC93TVlQd3crbndkWmhFcFQxUlpidXdkYjZzd21sZzVSNks3MzNhbU9xcTUz?=
 =?utf-8?B?cmh2SHNQS0hZSzV1R21ldVBNekZkVThGTnlBVW9aRkJCTk5lbGdCQ1JYdm50?=
 =?utf-8?B?dHNqMVBKQlhnYnBMR1A5M2NMeVFJa2t3bkNCM3ROUlViRXBncVgyc3JGNEp0?=
 =?utf-8?Q?BoaUvKLdXqB3ymwGpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f025e21f-920f-4d8b-543e-08df41965994
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:56:51.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgeqJQhaHqCZmTDL6aYuf+TOoD/eYeVBfYiP8t8FPaBrhSA+j/7801yLVHLrAPBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB463434

Hi Andrew,

On 11/13/2026 6:50 PM, Andrew Lunn wrote:
>> +      xlnx,max-learning-entries:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        minimum: 256
>> +        maximum: 1920
>> +        default: 1920
>> +        description:
>> +          Maximum number of addresses the hardware address learning engine
>> +          can learn on each network port (MAC1 and MAC2). This is the
>> +          MAX_LEARNING_ENTRIES IP configuration parameter, and no register
>> +          reports it. The endpoint port does not take part in hardware
>> +          address learning.
> Is this a synthesis parameter? No other switch that i know of has it
> in DT. The driver hard codes the value based on the compatible. Why
> does that not work for you?
   Yes, MAX_LEARNING_ENTRIES is a Vivado synthesis parameter of the IP
   (256 to 1920), and no register reports it, so one compatible can carry
   different values. The endpoint driver in this series does not use it.
   It will be used by the DSA switch driver.
>> +      mdio-1:
>> +        $ref: /schemas/net/mdio.yaml#
>> +        description:
>> +          MDIO bus controller for MAC1. Registers reside inside the mac1
>> +          reg-names window.
>> +        unevaluatedProperties: false
>> +
>> +      mdio-2:
>> +        $ref: /schemas/net/mdio.yaml#
>> +        description:
>> +          MDIO bus controller for MAC2. Registers reside inside the mac2
>> +          reg-names window.
>> +        unevaluatedProperties: false
> How hard coded into the design is the number of ports? The way the DT
> is structured, it does not seem easy to add another port. It is more
> normal to put all port properties within one node, so you just need to
> cookie cutter that node, not add new nodes all other the place.
   The number of ports is fixed by the IP. The switch always has two
   external MAC ports and one internal endpoint port, and no configuration
   has more external MACs, so the binding never needs to grow another port.

   The switch node follows the IP's register map. The switch fabric and the
   two MAC blocks are separate register windows of the switch IP, and each
   MAC window also holds that MAC's MDIO controller and PTP block. The PTP
   timer interrupt is shared by the whole switch, not owned by one port.

   For these reasons I would prefer to keep the per-MAC resources on the
   switch node

>
>> +        switch@38000 {
>> +            compatible = "xlnx,tsn-switch";
>> +            reg = <0x38000 0x8000>,
>> +                  <0x00000 0x14000>,
>> +                  <0x20000 0x14000>;
>> +            reg-names = "switch", "mac1", "mac2";
>> +            mdio-1 {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                phy0: ethernet-phy@0 {
>> +                    reg = <0>;
>> +                };
>> +            };
>> +
>> +            mdio-2 {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                phy1: ethernet-phy@1 {
>> +                    reg = <1>;
>> +                };
>> +            };
> Interesting that this is address 1, where as the other is address 0.
> Just to be sure, there are two fully independent MDIO bus masters?
>
> This
   Yes. Each MAC has its own independent MDIO controller, with its own
   MDC/MDIO pins and its registers inside that MAC's register window.

Thanks
Srinivas Neeli
>
>> +
>> +            ethernet-ports {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +
>> +                ethernet-port@0 {
>> +                    reg = <0>;
>> +                    ethernet = <&ep_mac>;
>> +                    phy-mode = "internal";
>> +
>> +                    fixed-link {
>> +                        speed = <1000>;
>> +                        full-duplex;
>> +                    };
>> +                };
>> +
>> +                ethernet-port@1 {
>> +                    reg = <1>;
>> +                    phy-handle = <&phy0>;
>> +                    phy-mode = "rgmii-id";
>> +                };
>> +
>> +                ethernet-port@2 {
>> +                    reg = <2>;
>> +                    phy-handle = <&phy1>;
>> +                    phy-mode = "rgmii-id";
> Are these two PHY internal or external? Using rgmii internally is O.K,
> but odd. Normally 'GMII' or 'internal' would be used.
>
>      Andrew

