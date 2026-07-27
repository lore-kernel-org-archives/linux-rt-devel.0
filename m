Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4213F6C24
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148559; cv=fail; b=J40Uzy2yQFWi81+h/P73N4T75IZFpL7xid6twL5NhwrdW6eU1ttNBNPWAhj03EROxvSEiPElXH/knALT/OeR6j55hy6MNCH9KY+2yLxf9KWviYv2BlkEX+OBtxcVqaKxvVTy1ExqFnvJRKKG5jGqZ31qoO84LT+spsufyyRv6E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148559; c=relaxed/simple;
	bh=udGiV8N57qYawuFMmVETjJ3+qS5rqCzhyYB9iXXTDJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pt8avyKZA9PvcM8mer5EKhLxFvnS+FK2J/CUN/5cCIRoZPiaygHNg47sRA5CztTA7x7+Ts1M5T1QvY7DZwzn1WDqf45dBQEXEA98SPBKHMMNPZFFav0/2NmpFEB9q3BavGPDcwHFFUeY5smLdw++PwT5j4MKvR4uqihBtoEU5mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kdE4fIIf; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kdE4fIIf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOZsX9BwHli4Xy153NTqjGOLFgIPKJAh6Z7yDdTbYFA42PogoNmaFsz/5/tb00GbTYSIVZxpkigIzC16C24oPtDpqijQjfrjMnIn4FPBj6iEM9I/+J7mOzJ1GKu/a1pgdHe51BhwcALLSwssRkjnnM+lplm4HZHtE+XNEtfivlINSmky/zlWLGNzsHDMMtljM9YOUMVdwwwNtjr0dfuxdSC1usdk4igS0zpvFhjNQ2YdwNuAEds29ILLD3h1g0rR9PyisAQmJwVX6zXCNLp0tn7OV8wx5wedtdExKDWXyM20zdJQxwhe+Aal7tnmHWc/iWS/w9GdcD5CZmTw0vG7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udGiV8N57qYawuFMmVETjJ3+qS5rqCzhyYB9iXXTDJc=;
 b=mb+zos8RcatXt3aJ9BrxtqCOzTi3qpcXbBSMqzC6QUXk6wMTfwZsc/lQdaZEJgv6QLjrGUq8qODXcK+f4YBTQiU9jrNQTEVfF7hr7PeWhsKN9Qh1zUHh5AmodehlmAWFKnw3jTissyLuGPHhC5ZUDxK2jYJJhbo6VOcWPTaQrb9Vzm/SzuEgGN3F8YZVZ/6EQ6SDov1f5WDKMCX1rgQQ4JbXaHwIM6OQBoa1JXNcLpLStllhC466agemUByWmR5vSf3kVM1EBx8HbBYNjnhWT5teLSbZr8hkenK3nnc46jrDJiw1JsArhCmwASyY+WsmL+UytF8FbDDrRug6P1r+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udGiV8N57qYawuFMmVETjJ3+qS5rqCzhyYB9iXXTDJc=;
 b=kdE4fIIfYJwgGgC4AvB2e1bbo1IhJ3pxFnZG12C4JaAqX7wICYnBU1otUGvfqhq6EJ2V7iWezlsQUcNjopF4zp0YDaJp3HEIepiu5OZhoRyd/SKS+yTs2yh8F88ltNq7SYb0FMI7fM/4pq83gJ+jWW+BmQ5yzU9CXujFnEQItSo=
Received: from DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) by
 PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:35:47 +0000
Received: from DS7PR12MB5838.namprd12.prod.outlook.com
 ([fe80::426e:9c0:cd80:2594]) by DS7PR12MB5838.namprd12.prod.outlook.com
 ([fe80::426e:9c0:cd80:2594%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:35:46 +0000
From: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
To: Bert Karwatzki <spasswolf@web.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Re] kernel panic during shutdown in  v7.1+ with PREEMPT_RT
Thread-Topic: [Re] kernel panic during shutdown in  v7.1+ with PREEMPT_RT
Thread-Index: AQHdHa+zmttzCcrd7UqpFpB4xuS94LaBJWVA
Date: Mon, 27 Jul 2026 10:35:46 +0000
Message-ID:
 <DS7PR12MB5838D278341AE35E0383B951F8CC2@DS7PR12MB5838.namprd12.prod.outlook.com>
References: <20260723131001.11565-1-spasswolf@web.de>
													 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
											 <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
										 <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
									 <3c1be47abfcc907e7c1f9696cb25a24c93415a28.camel@web.de>
								 <dc5f1cfb267b0fb522b8aaa236b71b23e236df4d.camel@web.de>
							 <4af8467060c5ee136c2b99ab855a007fec4e8c6c.camel@web.de>
				 <6e0b713cffd64b3c30eb4ff04e50721bac9cf8ca.camel@web.de>
	 <f012ef660c71e5d85bd746caab2f6a6e456671de.camel@web.de>
 <5b5559e0fcc162bb0a2b7ab9764b8040c981c1d5.camel@web.de>
In-Reply-To: <5b5559e0fcc162bb0a2b7ab9764b8040c981c1d5.camel@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-27T10:35:46.059Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5838:EE_|PH8PR12MB6964:EE_
x-ms-office365-filtering-correlation-id: e5a48398-5b65-434b-45cc-08deebcad1bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|10067099003|18002099003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 aqOTJaE2WUSzXeGhQJaTa6IUdoONFrvmNXbcgBRZDmaUBlj6OmkeFGq2mFNOiTCOvpeOm+wbJHulerCNogLDNEkq1oGn91H0+hA87mu/GTWxKFWF9eEsxKEAJwJ4llpuSMghoYCKNNr17QOgDYbq2SNw4TjI4QQPwXMxHSegy5MqMEz8mFy/bLyKh/VLTnhOclEGWbzOgh21bXvHINi70goGnXDE6MWvM2roWqd1ZZ/pGTFFqDwssFJs03ekgBG2yUxQZgUIf2DvM0NRbT7V+i8ilLiv0EjeyLTJTkmQFv3vhSO1mUP0V8UXmsYx/U+/zovgSFN0ArZtgZ3d2t4hzq4c4N5xDNLJwtOzbsU+NuWA3zuEHHx2LyqiczFf7hjN6Qi8pn4rAxSe08duVV71m8K2933ml514eYALnOHoXBpqOnb1oU0kbAYm+L5sMaBbdO7taQA7r4WYjn6JppfmWAlXDeyxz3qs2BI1Eq5Qo3ckFXEA1Upp/apV+JjRgkhiokYFU5rgnoUVotSoeNB7TTQ/aFYEoTfV+5uKJNGlSMS8I5XolOoZKqhIOYKUOyFrTt4BxImAGhTCGnGE4HfpZjgfYuRMDteHF0nYYRea0mSd+rCpkq2lJdD13op9spQUtBvOLqniVOeL3JcPPNY3P2YHyCM4Ym3w4bzpDFCbzpzpfr5BiViyFkUXY4RBJZtgrU2luV8rYsjq6pAH1jkqLmwvvr5YfULZdu8btd2c6pU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5838.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(10067099003)(18002099003)(4143699003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2djN2VrNmZ6azNFbFJvdmNZbDZlaHNpWlRJUVNxTElHSEM1YktpRWpXMHgx?=
 =?utf-8?B?ZXk3TlJ5Ym95alZqNkZuS0RqYklhYzZRVXFEOFZIbEhnV3NSRlF3TU54VUNN?=
 =?utf-8?B?RVR3VkVqS3lkNUJYWFZNZlE5cWhLUGtodkhtcEtHTXVCZ2FoMEltSHdMdWJO?=
 =?utf-8?B?R0NsYy91dFI0TE9kMlNjWVo2L2dwTUtQdDdnZURteDV5c0JsSzdtWXJsTGsr?=
 =?utf-8?B?YnhpVUxsNHIzM0xuaFBlVkhmaXZNN0gvQk04RkFxeU5uNFkzVEZEN2FKT0tM?=
 =?utf-8?B?eisvTjRmNWFVQ3JMVkJ0dWdoNm9XQTlNdmJmZ3NweWZoaGlCUmI0ZVRndkJX?=
 =?utf-8?B?S0hSajFpSHEzMXh6RU95QnBMRitMekhJK3ZDR1VXdnRPRVowU1UzenRWL3RM?=
 =?utf-8?B?WTl1aE9JYllCTUthNHk3cVdndC9IMldJc0ppdS8rdk0vNnZybGpMZ0dKZTNW?=
 =?utf-8?B?QnNkcTRkMTZlazZzOG9UdWw1Tm1wWEpjakRwMFVUT0pheGRlTEhKMW84QUk3?=
 =?utf-8?B?RTZieFpxV3Z6azBmcU5iLzhpV2VnT0hXckNVZEZTUUxsMlpyZGh3b3pFeG9K?=
 =?utf-8?B?QUJWUDFvVVR5c2laamMwRXhsb0dVS1BhKzM3VmMwR05vMFhsOEdtOFZueWVk?=
 =?utf-8?B?Z3VqcUlKWExPSEhiby9rcVVselBVM3JkSXVGNFU5OVN0MWZ5WUE2eU1ZdGN3?=
 =?utf-8?B?YVlLK0JJMGdPOE16UWpseVA4Z1N0NWFOZWpYby9YMTRFdU5aRW9taTFzQWNa?=
 =?utf-8?B?SVpxYjNiVExpZHJsa0IwL1AwcS9ENUhudlVnWitic0hRd05pZ1dFL1dOSWE1?=
 =?utf-8?B?TlN5S0ZIVkZsMHpHRDA1UUdKQzRFWFRBTkhaaHZQREQxZUU1K3k1NENVSjdC?=
 =?utf-8?B?TFB2QW84Z2NNS1g3UFk4c0szdEJkSDR4cGtYeHEwMFRqaGMyaGEvZTJ0NWRw?=
 =?utf-8?B?WDFJZFpWZGV6L2hPT0NWa3UxdEZLK2dZMks1cWpsN3NUVXF5UGJXN2cyNDV2?=
 =?utf-8?B?clMxcFZaYVRZelVBRGxYRklkZTFCTTJUZWtjcmN3b0xpZUNkS1ZvRXplOVpW?=
 =?utf-8?B?YWkrU1E3TXJ5R3JEdnhKWlY4bk5NVktCTkVOV0N4WHFNMzhVUUZnS3IxcVdF?=
 =?utf-8?B?NjlueUgyZXZuVlI0czdaQWx4MTJDUjBVVHJpcnJUU0E0dmtORXF4QXg1UUEr?=
 =?utf-8?B?MVBNaGE2OHZWNVJCNUY3QisrMFJIV1A4SFBKNWd6SjFjblp6VksyNXExYzYw?=
 =?utf-8?B?VFE5OWU2SDFxeWVUeTNHQWxqUE5qNE92Sm04aDBDdFhkbnB0WE5jTE9icjJC?=
 =?utf-8?B?VEpwR2RFVWRzQm16ZkxJaEErbjNlaHBaVkVSVzAzWng2NE5aMDFYY04yRlk4?=
 =?utf-8?B?Q0k5YnFJb3VpZXd5cTRITElZV0lMdlh6RmhwYzA2VjBqS2kwVkp4YldLZ1hO?=
 =?utf-8?B?ZVEyUTJJTVdCWmNrek1mOUN3L2tPM2pVQUQwTjNSMWpEQW1Rd1ovSXI3QmE4?=
 =?utf-8?B?SVBXckVDd3VhWFpsYWJHYWJEMFlSY0FsUHE3VnljT2JxQ2dEV01zb29yaENz?=
 =?utf-8?B?VHllQUhjVU1HTXQrL2tHVXVRa2s2SkJqc1hESzZRLzV1ZlZocWE4TXYyZWNS?=
 =?utf-8?B?Y1h0SnJENmZGaURNNUtLVlh6Sk5NeFNsMkdFckM3ekNkQTVsMmdVenQ1Nk40?=
 =?utf-8?B?dFhvWWgwRzB4clRXaEJjd20wUkJFQ010clg3bGJhNE45cTNMdEEzNnhEWW5G?=
 =?utf-8?B?N2hON3M5cFVubkZCakNTS0dYY2l6ejlZYjBRMk9HTU1PTGdvOHRvRjJZVG1Y?=
 =?utf-8?B?YnpEc3FuWVYwLzZNeWRERUNwVEZBT2lvR2RnRkFIZ3grQzNoMmpjSGsyeUg1?=
 =?utf-8?B?ZjRlbGxsRm1PTmtzZENQSDZQUGY2MjZadmVsZmJuZ0tuYmk2OHdTM2drZ0Nx?=
 =?utf-8?B?NzFQUVBqZXB6RjQvNCtpNzRVTXZXV2RJcytkcXBRT0V1T1ZaVXAzdFYwSm1y?=
 =?utf-8?B?YmtEbVJ1WWpTNnFWd1g2TSs4Rkl1Qy9ZWWlkeEpCaWgvZzdZS0kvTmNzcWhF?=
 =?utf-8?B?R3h5dmhkRlJWSUxTNzBSYmNpMzB4NngzY2Q4N29LYXBReExCcit4VHNCYzhk?=
 =?utf-8?B?ZlFwWlJ1SFhtMUZGZEprWGhPRUQrUFpJVVJyaDVWMDVaM0IrNnZZTzc1ZGZZ?=
 =?utf-8?B?c0cycGp6cmZmcFJ1YTdycS9PQXBzNlRDbjh2N3p4Q1hJQ2VBVlhKclRYMytp?=
 =?utf-8?B?ZHVLYVEvbVVhYUxKcFNkdlhqV0NPWWxLQTlqOTlyRzF3Nms3cVNINTI1cVA4?=
 =?utf-8?Q?lu8/uweGazL+AEeSwC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a48398-5b65-434b-45cc-08deebcad1bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 10:35:46.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /M/uhRRm0Y9cgTBiXBM/6i9oGqsXL8tKDuTGrfjkVBnjNzNNYs1DfFwSEcpFsVMQqBb/ki3wD2v/RrPdFm2hYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964

PiBUaGlzIGNhbiBiZSBmaXhlZCBsaWtlIHRoaXMKPiAKPiBzdHJ1Y3QgZGNfcGxhbmVfc3RhdGUg
KmRjX2NyZWF0ZV9wbGFuZV9zdGF0ZShjb25zdCBzdHJ1Y3QgZGMgKmRjKQo+IHsKPiDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgZGNfcGxhbmVfc3RhdGUgKnBsYW5lX3N0YXRlOwo+IMKgwqDCoMKgwqDC
oMKgIERDX1JVTl9XSVRIX1BSRUVNUFRJT05fRU5BQkxFRChwbGFuZV9zdGF0ZSA9IGt2emFsbG9j
X29iaigqcGxhbmVfc3RhdGUsIEdGUF9BVE9NSUMpKTsKPiAKPiDCoMKgwqDCoMKgwqDCoCBpZiAo
TlVMTCA9PSBwbGFuZV9zdGF0ZSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIE5VTEw7Cj4gCj4gwqDCoMKgwqDCoMKgwqAga3JlZl9pbml0KCZwbGFuZV9zdGF0ZS0+cmVm
Y291bnQpOwo+IMKgwqDCoMKgwqDCoMKgIGRjX3BsYW5lX2NvbnN0cnVjdChkYy0+Y3R4LCBwbGFu
ZV9zdGF0ZSk7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHBsYW5lX3N0YXRlOwo+IH0KPiAK
PiBJIGFsc28gZm91bmQgbWlzc2luZyBEQ19SVU5fV0lUSF9QUkVFTVBUSU9OX0VOQUJMRUQgaW4g
YW4gZXJyb3IgcGF0aCwgSSdtIHByZXBhcmluZwo+IGEgcGF0Y2ggZm9yIG5leHQtMjAyNjA3MjEg
KG5leHQtMjAyNjA3MjIrIGhhdmUgYnJva2VuIHJlYm9vdCBkdWUgdG8gdGhlIG10NzkyNSBpc3N1
ZQo+IG1lbnRpb25lZCBhYm92ZSkuCj4gwqBBbHNvLCBpcyBwcmVlbXB0X3tkaXNhYmxlLGVuYWJs
ZX0oKSByZWFsbHkgbmVjZXNzYXJ5IGluIERDX0ZQVV97QkVHSU4sRU5EfT8KPiBDb3VsZCBtaWdy
YXRlX3tkaXNhYmxlLGVuYWJsZX0oKSBiZSBlbm91Z2ggaW5zdGVhZD8gVGhpcyB3YXkgd2Ugd291
bGRuJ3QgbmVlZAo+IERDX1JVTl9XSVRIX1BSRUVNUFRJT05fRU5BQkxFRCBhdCBhbGwoPykuCj4g
Cj4gQmVydCBLYXJ3YXR6a2kKCkhpIEJlcnQsCgpTb3JyeSBmb3IgdGhlIHRyb3VibGUgdGhlc2Ug
Y2hhbmdlcyBjYXVzZWQgb24geW91ciBzZXR1cC4gSXQgcmVwcm9kdWNlcyBkZXRlcm1pbmlzdGlj
YWxseSBvbiBQUkVFTVBUX1JUIOKAlCB0aGF0J3MgdGhlIGtleSBjb25kaXRpb24gaGVyZS4gT24g
UlQgdGhlIHBhZ2UgYWxsb2NhdG9yIGFsd2F5cyB0YWtlcyBhIHNsZWVwaW5nIHJ0X3NwaW5fbG9j
aywgc28gYW55IGFsbG9jYXRpb24gaW5zaWRlIHRoZSBGUFUtcHJvdGVjdGVkIHJlZ2lvbiBpcyBp
bGxlZ2FsLCB3aGVyZWFzIG9uIG5vbi1SVCBrZXJuZWxzIHRoZSBzYW1lIGFsbG9jYXRpb24gdXN1
YWxseSBzdGF5cyBvbiB0aGUgZmFzdCBwYXRoIGFuZCBkb2Vzbid0IHNsZWVwLCB3aGljaCBpcyB3
aHkgdGhpcyBoYXNuJ3QgYmVlbiB3aWRlbHkgcmVwb3J0ZWQuCgpTb21lIGNvbnRleHQgb24gaG93
IHRoZSBGUFUgaGFuZGxpbmcgaXMgbWVhbnQgdG8gd29yazoKCkRDX0ZQX1NUQVJUL0VORCAoRENf
RlBVX0JFR0lOL0VORCk6IHRoZXNlIHJlcXVpcmUgYSBub24tcHJlZW1wdGlibGUgY29udGV4dC4g
VGhlIGtlcm5lbCBuZWVkcyBleGNsdXNpdmUgdXNlIG9mIHRoZSBGUFUgd2hpbGUgd2UgcnVuIEZQ
IGNvZGUsIHNvIHByZWVtcHRpb24gbXVzdCBiZSBkaXNhYmxlZCBhcm91bmQgaXQuIE5vdGUgdGhh
dCBrZXJuZWxfZnB1X2JlZ2luKCkgaXRzZWxmIGRvZXMgcHJlZW1wdF9kaXNhYmxlKCkgKHZpYSBm
cHJlZ3NfbG9jaygpKSB1bmNvbmRpdGlvbmFsbHkg4oCUIG9uIFBSRUVNUFRfUlQgYXMgd2VsbC4g
VGhhdCBkaXJlY3RseSBhbnN3ZXJzIHlvdXIgbWlncmF0ZV9kaXNhYmxlKCkgcXVlc3Rpb246IHN3
YXBwaW5nIHRoZSBwcmVlbXB0X2Rpc2FibGUvZW5hYmxlIGluIGRjX2ZwdV9iZWdpbi9lbmQgZm9y
IG1pZ3JhdGVfZGlzYWJsZS9lbmFibGUgd291bGQgbm90IG1ha2UgdGhlIHJlZ2lvbiBwcmVlbXB0
aWJsZSwgYmVjYXVzZSBrZXJuZWxfZnB1X2JlZ2luKCkgZGlzYWJsZXMgcHJlZW1wdGlvbiBvbiBp
dHMgb3duIHJlZ2FyZGxlc3MuIG1pZ3JhdGVfZGlzYWJsZSgpIHdvdWxkIG9ubHkgcGluIHVzIHRv
IHRoZSBDUFUgKGVub3VnaCB0byBwcm90ZWN0IHRoZSBwZXItQ1BVIHJlY3Vyc2lvbiBjb3VudGVy
KSwgYnV0IHRoZSByZWdpb24gd291bGQgc3RpbGwgYmUgYXRvbWljLCBzbyBpdCB3b3VsZG4ndCBy
ZW1vdmUgdGhlIG5lZWQgZm9yIERDX1JVTl9XSVRIX1BSRUVNUFRJT05fRU5BQkxFRC4gVGhlIG9u
bHkgdGhpbmcgdGhhdCBhY3R1YWxseSByZS1lbmFibGVzIHByZWVtcHRpb24gaXMgbGVhdmluZyB0
aGUgRlBVIChrZXJuZWxfZnB1X2VuZCgpKSwgd2hpY2ggaXMgZXhhY3RseSB3aGF0IHRoYXQgbWFj
cm8gZG9lcy4KCkRNTCBsYXllcjogdGhlIHdob2xlIERNTCBsYXllciBpcyBjb21waWxlZCBhcyBG
UFUgY29kZSAoc2VlIHRoZSBGUCBjb21waWxhdGlvbiBmbGFncyBpbiB0aGUgbWFrZWZpbGUpLCB3
aXRoIG9ubHkgYSBmZXcgd3JhcHBlci9leGNlcHRpb24gdW5pdHMuIEFzIGEgcmVzdWx0LCBhbnkg
ZnVuY3Rpb24gdGhhdCBjYWxscyBpbnRvIERNTCBtdXN0IHdyYXAgdGhlIGNhbGwgaW4gYSBEQ19G
UF9TVEFSVCgpL0RDX0ZQX0VORCgpIGJsb2NrLgoKRENfUlVOX1dJVEhfUFJFRU1QVElPTl9FTkFC
TEVEOiB0aGlzIGlzIHRoZSB3b3JrYXJvdW5kIGZvciB0aGUgY2FzZXMgd2hlcmUgd2UgbXVzdCBh
bGxvY2F0ZSBvciBzbGVlcCB3aGlsZSBpbnNpZGUgYW4gRlBVIHJlZ2lvbi4gVGhlIGltcG9ydGFu
dCBydWxlIGlzIHRoYXQgdGhpcyBtYWNybyBtdXN0IGFsd2F5cyBsaXZlIGluIGEgbm9uLUZQVSB0
cmFuc2xhdGlvbiB1bml0IChhIERDIGZpbGUgb3IgYSBETUwgd3JhcHBlci9leGNlcHRpb24gZmls
ZSkg4oCUIG5ldmVyIGluIHB1cmUgRlBVLWNvbXBpbGVkIERNTCBjb2RlLCBzaW5jZSBpdCBtYW5p
cHVsYXRlcyB0aGUgRlBVIGd1YXJkIGl0c2VsZi4gV2l0aCB0aGF0IGluIG1pbmQgdGhlcmUgYXJl
IGVmZmVjdGl2ZWx5IHR3byBjYXNlczoKCkRDIOKGkiBEQ19GUF9TVEFSVCDihpIgY2FsbCBETUwg
4oaSIG5vIGFsbG9jYXRpb24vc2xlZXAgaW4gdGhlIERNTCBwYXRoIOKGkiBiYWNrIHRvIERDIOKG
kiBEQ19GUF9FTkQuIENsZWFuIGNhc2UsIG5vIG1hY3JvIG5lZWRlZC4KREMg4oaSIERDX0ZQX1NU
QVJUIOKGkiBjYWxsIERNTCDihpIgRE1MIGNhbGxzIGJhY2sgaW50byBhIERDIChvciB3cmFwcGVy
KSBmdW5jdGlvbiB0aGF0IGFsbG9jYXRlcy9zbGVlcHMg4oaSIHdyYXAgdGhlIGFmZmVjdGVkIGNv
ZGUgKGFsbG9jYXRpb24sIHNsZWVwKSBpbiBEQ19SVU5fV0lUSF9QUkVFTVBUSU9OX0VOQUJMRUQg
aW4gdGhhdCBEQyBmdW5jdGlvbiDihpIgYmFjayB0byBETUwg4oaSIGJhY2sgdG8gREMg4oaSIERD
X0ZQX0VORC4KVGhlIHBoYW50b20tcGxhbmUgYWxsb2NhdGlvbiBpcyB0aGUgc2Vjb25kIGNhc2U6
IERNTCBjYWxscyBiYWNrIGludG8gZGNfY3JlYXRlX3BsYW5lX3N0YXRlKCksIHdoaWNoIGlzIGEg
REMgZnVuY3Rpb24sIHNvIHRoZSB3cmFwIGJlbG9uZ3MgdGhlcmUuCgpBYm91dCB0aGUgZml4OgpE
Q19SVU5fV0lUSF9QUkVFTVBUSU9OX0VOQUJMRUQocGxhbmVfc3RhdGUgPSBrdnphbGxvY19vYmoo
KnBsYW5lX3N0YXRlLCBHRlBfQVRPTUlDKSk7CgpUaGlzIGZpeCBsb29rcyBjb3JyZWN0IHRvIG1l
LgoKS2luZCBSZWdhcmRzLApSYWZhbAo=
