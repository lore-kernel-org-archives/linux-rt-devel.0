Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795155287;
	b=1iVcdTgBnEyYrST8pYjt6LshcJS4ih3prgIyo7GiF9AHmFMFrkRQkreS25ohtyCd7o4t
	 EWbCBbKFeqsN+GsCWs+hUQ92l6CJD5VtCLYNmH02mP5jS7jdaUCu8449RtACa4Z9pbHGo
	 Y7oPTjYJQqSD9PSbbPmk10CoVrRRViHqJfaUDP1T88zMby7qAFp41icxcEhnf+1IIESeS
	 4rCLVAPt7UlYsbyTgVrFjw6I4sFHSJleq0CaNPjcEgxdfk6xutH3VSaIxaF0/nlHROehu
	 nmw/rMVZK9ZTMsoDiTyo86Lu9Uw3OzssAURULtFP9sYYghPOFnLfivSm3OVc4vki8Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155287;
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
	bh=K9JfGQMU2goXJLe85ptXZvz7/zWBEF657E4/lwaUP0Y=;
	b=mNrsifn/QSLwzEmKkXQU49vE+ktyAe1P8QwMKfOJ0Uq5775YAuk4uDlYDhzAvkg74LgC
	 HBTD0up647V56sc3jD3CddfDteRo7S53keCWq4CmUQi97ChB6mCWRBIIvkPlLJxNnSKHN
	 FJC/hVHcI3yRIYv8tR9J82h1t2o/nCUEzeC4f7QYqkwKv7vbgl0gdB1z3RX+vArp305dw
	 96Q0HWqJAwqyTSLz7lpvl1R9PJdFnzuIEaNwtuygLC7xayI9eSt8qB5XiYKPgGntWRy+0
	 UxlEu88iXj9lQSCfhNE8+3oUz+AjHdwOK7EUI5k0VMXdesXrXZVopdoClskg5FFdT5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0wFDOqdj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.38
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA4606A50A
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 06:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DDA4606A50A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0wFDOqdj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4dchM9bg3sH1m8InLMCisVRNDDxajdhmzd1z2Vefti6TuCnJklN0swiKdGeEUPXWj0mUkONuFcfP1Cv8D+/9M9pptASkSAUcNi+D7NGQe2QyloHZfI8s1+EisH5VuJTOR7+w3FhTnrgYBYUZCgfX1xNUqIy2UAyDN1kmz77hPljDI9HOzZyIHRYEqPZbuwV8KMYRWjDkpG45iZRM/7nQDy6Me708vKEjPubBy1a4s6SovDrMjePnocI1icCqYP+fpOjoKtqiksMFYYKV3ImL2yOqReqZMewwweRl53PHTm8jPgNQwXmypP1yBzpdit44TrfZQq5DB1rbwZiqQNV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9JfGQMU2goXJLe85ptXZvz7/zWBEF657E4/lwaUP0Y=;
 b=tYQx/I8KaYCteS1ZDacBJ/V5rQDk/zlAijizzKLfPTBXPQ9Do00KcDMRqjRe9xFmrDzYlc5rNsU0h9OrKg9xhXHrHY9CKsksjcDnud7F/vAElcKNQ9WHKK1OfCcpV7ih59IiKNu34gop2ly8R/UADg+WAA7U6rzvSUaniFwaCylHbsRBDlFq9dLG26Ved/IcqpwBVDn2fsPBqAlPQe9ENQVEyShV9/5HNl2n4MoXqT0c1TmTClGqMOzBmjSbXIlDdkwJB30S/mWCpUvBieZUibg8Opb83+YCEq0HWJaiqZVm69M5B/7Ru8ZaaJGxW5XBBlRVxivCXwg8kvXhHtxKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9JfGQMU2goXJLe85ptXZvz7/zWBEF657E4/lwaUP0Y=;
 b=0wFDOqdjvjlgbK0VvJ7aTw4XiKHgJQHs74dRF+Sqew5dLvD0ofn3ofLA/D6hQ/y14UVSxLA/e8R7b0Tm6YqiA4hhCQoj54eAjCmsYNNJEGvUUqVMinL7DPH+3yIOEGpqjFRTr3kpiRWhJapDzFggl5hiZ9nV3XSwp1F67khZGqk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 06:12:32 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 06:12:32 +0000
Message-ID: <0c2f1f3d-43a2-440d-8d09-652e159e82ae@amd.com>
Date: Fri, 20 Nov 2026 11:42:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/8] dt-bindings: net: add Xilinx TSN Endpoint
 Ethernet MAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>,
 Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>,
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
 <4254be1a-f80e-4389-b04d-9fd10c1b77b7@amd.com>
 <ff25f481-3ea3-441c-826e-75c22b47fac3@lunn.ch>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <ff25f481-3ea3-441c-826e-75c22b47fac3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0280.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::13) To SN7PR12MB8147.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: ce43e65d-a4a1-444f-9b48-08df46cd4317
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|3023799007|11063799006|5023799004|56012099006|10067099003|4143699003|261102123227099003|261102130727099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	kvIc9GfhkumOCPZhRzJYGK/Wx/UZpVK3e1d7QGOC2Hc4TO15KTYrqJuZ+x+au6du1Q0OLaN0+jCPL9ZSnqqQXz1JTf0/vrvwdMucMVP4/KN/EvQHZJCV5n9ZDbHtkbsAeoQpQcDyRfOMrQxnmfI6rWo4TB3ovmvO1hAbpgk8kVtLhZSZRvDwGqujT+4l2e8SXJJK5ufROwi3RXQGrdK5vYsJjkYS0rgiNLe5Ag37AZcThsHhBx18XWxjkbaDjSdXkVgg3jn4UThY+8S2tJ+ikaarK3h0t5N3dC3sTynNoHL2LuGld9hBecYwGE3R+uXfQ4ITGmoer/9JIIpFDkwAThOUWptAJVN4EUIO8mt2ToMWFcBDL0jS12t5TeCdv2XTy2wZ/BuyvqQ/6TV5GxuZVnzAmGeO+j4q6AF7xeK3zAv1kZtHADLL5QKKjp2ep3DMuX+GPsVZTasSIgtOdTSGc7NMVKivhQNXCEZWUgTOdZQKeeSHx1yYySsqKxVULclM7sVerF5gDuzbTsNp1MZTFtMebckz8gt8SY7128T+z0SpS7vqWHnL+xlEQ4ngn9oKBxQkUxSz1WbiggioPkdvLfThQoINQzRwso+NC+Y9MVB3vGL/VnWVnUhxRebox/zx9Pi0z6nX8J0pL/cF8cbbay5iIB4+GMJfdYPDSUCWhDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(5023799004)(56012099006)(10067099003)(4143699003)(261102123227099003)(261102130727099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3B1ODBOR2hTRVdXVjlqQllkR1dqZDdRUnE3MzJBSGZQZDRjbTJFeXZ5ZzZJ?=
 =?utf-8?B?KzNzWHZDYm5wWEdZc0diK2w0Z2NaWmpUTGZEdWk2bEp3VklLQWJ6NDNBM2xX?=
 =?utf-8?B?V0EwWlAyMjJ3Vm5RK3hvd1ZJNWowNE5LTFhzcU1GcXJLR1ZKbWFEVDRHMmRs?=
 =?utf-8?B?TmdzWEdXNXVmb3RhVG9RRHhNUm5uRmQxZkVJWllFdXhQVG5ZUG0xNzlzeWFD?=
 =?utf-8?B?QWYyNmRrbWx5Q1A0TjhlV05xT3Z4TWUxQ3NjUC8rT0ViTTE0OWtoeHk4bmVJ?=
 =?utf-8?B?NlhOUVJ2a3Z4cEIxdUg4NC9GOVd6ZkZyTkdjQUdNbGdFQnMzajg0T052dEhN?=
 =?utf-8?B?VkhuL3ZEQVlzN3JKdnFBdG9MUWtNZjV4bjlXR1FCT3RaME51ZFFjdFhROEpZ?=
 =?utf-8?B?c1RrTHhNeWF4ZW9OeUlBU3JJUGpjTm1JY2JiQ2xMWi83UXpuV2JvMEN1eHFi?=
 =?utf-8?B?VmpsRnpzYzhKOXFuZU4ra1N6MThlRFI3clZYdGZPWGFRUkI3MWRxU3d3TXl5?=
 =?utf-8?B?bHJvNkxNUGYvNGdvTU5IdE1NS0FocVBxL1l4aDBGYmN2eWlRZ2JnTy9tZXVU?=
 =?utf-8?B?VnJTOE1vWHNoN08zQUhnR05PeEZ4alRjeTlzdEFNRmtlZmdlcGpRODNSTUhm?=
 =?utf-8?B?WGV3Y1BESnhIUEJ5bzZuOWJ0NHQxOUlCWWtIYVRGWXFxQWxtSDNqNWwwYUFV?=
 =?utf-8?B?czROdGFOeXpVb0tMSW11OFdSa1FEd3Yrd013bDY1RVdHZ2RDSHYrZi80NmJj?=
 =?utf-8?B?KzRPQ3lNRitZMU9FUmNpdzl2NVBNOWZWUHo0V05majF2U0JJY3dzM0EyV2Vo?=
 =?utf-8?B?c2tLUkV5YlQ3ZU9aMnY5MEtsREFGUTFDNldxTkpjaTdLY1RSaVRxbmhnZzNG?=
 =?utf-8?B?K1NzQU9sS1dsL0IyY202TThNWjllYmVVQ0ZWemFFck4veklyZ0d4YkNLWVRj?=
 =?utf-8?B?WFpweVZBTWllUVp1T2l5dm8zTmVqRWV1VjdKdlQ5T0NHMExUSmZGUXpoZWhz?=
 =?utf-8?B?VDN1YWNXTEdMZXdzUjA3MGREV3VDNDdDb20xbndhZXVhNUt6Um80ZTVsVzJr?=
 =?utf-8?B?ajRnV0ZjZjV5Uks3QURRR3Y5S1g2M1BNMTlyOUdyMWJyekFpYjR4d29TMHlX?=
 =?utf-8?B?VWlWS1Z5dFpJTi9qdWgzdlZmMFJXeHVkSFY5SjYvbWgrTGQwWkdLejFQbFdY?=
 =?utf-8?B?ZFV2WTZJZU40V3BudkhPZGNUNFAralRLQVBiSmFLUUNQOUw3Nmx2R1h2YlN0?=
 =?utf-8?B?MFl3eTdqTjkyNnV4dE9Ldjc2amJhM2kwZCthYVdONEsxK0wvczVpQjZMNVRm?=
 =?utf-8?B?MnBDSmNoTU14VGc4bThNMEkzK1RyK3dRVkNyOWZxWWRVejdha3RQbFFacFpw?=
 =?utf-8?B?MXd4UEZLY1NzTmtrMXkyT0xqak9kM2tySC9xY3NON1lYNHlWL1luUkhyNXdD?=
 =?utf-8?B?MXhXdGk2U1Rwa1p2N0NEcGlnYmRaWWxkTWdvcXJIRXdTWENVTzFoWGllZGk4?=
 =?utf-8?B?L1VSelloREYza2V4aXpUNjVLVktrbTYvUng1K1h6U2xoc3AwS25XTHJKSjM5?=
 =?utf-8?B?VlpKbUxBaEdGVUw0bnQ4amcrQTFtdEcxMVBhanVydW1BVk05U3JKOTh0T2Nk?=
 =?utf-8?B?Ym9mYUQvazVRRTdZcFVHaGV1Q3RqT3RsVFJQaVV0b29abDMwVkpWOHhqWnNu?=
 =?utf-8?B?cE1HUVdLa0FXUVFXaEE2cTBEaUJIY29HUW5pdmhBb25vUzV6WDNaQ3pKemVq?=
 =?utf-8?B?Q3E0d3djYlpZRU1BTVVLZThIc2YzZGVVSVNCWi9XanBSeVhxZkVpVWtidHA2?=
 =?utf-8?B?VURqNGRMMFJjUkFPRzVTYVdZSzIrWS83aFJEbStQVjQ1aGlwZlpsTGdlTmhB?=
 =?utf-8?B?dnk4b1lSS3FpUFNRZDBBQWpmS1FWSXlrdy8rK0RSL1kvN0xMNHdNc0NiQklP?=
 =?utf-8?B?bC83Z0ZQT1VHWVBHbUo4MndUbDd6TlJ2TEtlMU85elgvbWNrU0xGZ1FSWVNw?=
 =?utf-8?B?QVJpcTgra24rRUg0dFRUWlp0czVidTRzcWwrSzMrZ0RzWUlEUDdkOU5FTmx4?=
 =?utf-8?B?dG5aZHpGSXNLZmFucG9kWHpLS2lRS1BqbXdWYXVnb3ZvUVlSSjVsRTNuODhH?=
 =?utf-8?B?R25LKzlvVUhDWEVwUkw5U1UxQTBOZDBVZXhBaCtEVGxYKzRqODZ5UXZseDA5?=
 =?utf-8?B?b2JmZEpwbG5oczZSNm91RXpGT3JYR2NwRjl6TjRWNlphOGNPN0JVVWFVWW1I?=
 =?utf-8?B?MlN4V3VERUZWYTNmZEtHVXJkVUczcEVLUzRXOFB4cE1JSW5XakR5U2cvWWlM?=
 =?utf-8?Q?h3UyxbweHJsqztjHq9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce43e65d-a4a1-444f-9b48-08df46cd4317
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:12:32.1328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+qPfxCtyWMlJEUY62JaF9l7GqB0IyAZtWVhtWDfi7H7fYHrJUorHrWX7MSNLnWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606

Hi Andrew,

On 11/15/2026 3:13 AM, Andrew Lunn wrote:
>>> Is this a synthesis parameter? No other switch that i know of has it
>>> in DT. The driver hard codes the value based on the compatible. Why
>>> does that not work for you?
>>    Yes, MAX_LEARNING_ENTRIES is a Vivado synthesis parameter of the IP
>>    (256 to 1920), and no register reports it
> I assume that will be fixed in the next version of the IP?
     Exposing synthesis parameters is standard behavior for FPGA IPs, 
and not all of these are exposed through registers.
     Hence, I am afraid there is no plan to change this in the IP.
     For Xilinx/AMD FPGA IPs, these values can vary depending on the 
Vivado configuration,
     so the same compatible may have different values for the same 
property depending on the design.
     We have similar cases in the AXI Ethernet driver, for example, 
xlnx,rxcsum and xlnx,txcsum, which are based on synthesis parameters.
>
> Are there many other synthesis parameter which are not exported in
> registers? I just want to get an idea if this is a one off, or you are
> going to add lots of DT parameters in the next set of patches.
   Yes, there are a few additional parameters that we plan to expose 
through DT properties in the upcoming series.
   The TSN subsystem has several configurable parameters, and I 
understand that DT should describe the hardware irrespective of its 
usage by software.
   But given the volume of such parameters, we are considering adding DT 
properties in an incremental fashion, as and when there are consumers.

>
>>    The number of ports is fixed by the IP. The switch always has two
>>    external MAC ports and one internal endpoint port, and no configuration
>>    has more external MACs, so the binding never needs to grow another port.
> And that is signed off by top management? The next switch you design
> will be a fresh design, no reuse of the existing IP and will require a
> whole new DSA driver?
>
>>    The switch node follows the IP's register map. The switch fabric and the
>>    two MAC blocks are separate register windows of the switch IP, and each
>>    MAC window also holds that MAC's MDIO controller and PTP block. The PTP
>>    timer interrupt is shared by the whole switch, not owned by one port.
>>
>>    For these reasons I would prefer to keep the per-MAC resources on the
>>    switch node
>>
>>>> +        switch@38000 {
>>>> +            compatible = "xlnx,tsn-switch";
>>>> +            reg = <0x38000 0x8000>,
>>>> +                  <0x00000 0x14000>,
>>>> +                  <0x20000 0x14000>;
>>>> +            reg-names = "switch", "mac1", "mac2";
> I ask, because it would not be too hard to swap this address map
> around, put the switch registers first, and then the port registers,
> and you could have as many ports as you want.
>
> Back to what you just said:
>
>> each
>> MAC window also holds that MAC's MDIO controller and PTP block.
> So the MDIO controller and the PTP block are MAC properties, so should
> be inside the MAC node.
>
>> The PTP
>> timer interrupt is shared by the whole switch
> So that should be at the switch level.
>
> 	Andrew
   Yes, I agree with your suggestion. I will move the MAC and MDIO 
properties under ethernet-ports in the next series.

Thanks
Srinivas Neeli
