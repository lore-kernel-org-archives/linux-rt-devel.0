Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795034177;
	b=xdupEKAw/TlzdT1jt0N2mpOYClBRW2LMeJMiIB0RFz/3xGf5hTSyCW9cV2Q/GRel0uqm
	 XkwnypxKpskQr1eY8TWDBxtpVhtxwv/uAR8tNE9zc1PLE/YHT1RkkQUKr+zclCbrqrbxe
	 Ltka+E3Gcr1aL9YPolHNOTo6xqPHiyIYCpYLFEyUvj7PqhS4i0qEbWXml97Is+zzrDdg2
	 rgiMlFaaCagXvl+P69cxrH9+TNypqlhN5EQLWX19FzGRL/btf+hF+LSRLhNu3ZRTrjVM+
	 Evv/KTGoA6JNGZ2/xFe/gmMyHctpFFsFYWl5q7/dcC9ILmjVR4W3w/Pwk6m2N7DIBQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034177;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=t9R14NaI/JeikKnHJ+yahYnsuQHAHuBELGNZM0uMuvo=;
	b=HDvfAtY6y62NMPENk0XZ8sHINw2yqlOh006iQZbGx/cOwo2z4ffWik/wIj2UXiN69SQK
	 KwjKbwcZEztWqjcp3bQE+lL2cfCTH66akRdGSUBfSqtI1YgfHr0SFtXGocdnenIeurDX2
	 mRfRCLDw62vb0TSjySXwsOi5v+UwccIpiPes/30XSKUZOQAG9jI4zZfYr42u6xs7L2P1c
	 JtorUyVKuodUFQmXJlEFXdYaZLntDOXxB58mA+C+ccXu1mt89ZXb2rb+soyXMBD2G0UvZ
	 r1ToLpJ9v7hZl3Y1meTcILScdcatXzutXI0L4R3alr9iAC/CRTzBQDMToDoBt2EmTvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=estdNcX6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.140
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020140.outbound.protection.outlook.com [52.101.189.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E5606A33B
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 20:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E24E5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=estdNcX6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8ULfWrd2BVb3Dyze8FWHivQUHQq3qDx803rgJ7/sATwUTCDEMbbULLFks9M3T89oURVaKddvfu5YKMlzyKvANCCJmx+ak9Ipul6Pt3isgmlp8KWY6wri7x6sqtJAtX2S3zQEL0/Iu4cvDJg0w8j3jCOy8ruZtxfz7B4yoWAeQzEc70HJlWqXpW5FJwReZWDxBYQt/oxhedzl4G/xRnhmGjtVRZO/GLhPmqbblTuhKAfabrKe8N4R+pX+EgJUgTiMgzamHC+uISfbzjH+vPd5Iggi/m0ZxMyl/1OvlSKpabCM6bcCV9zofRcOcWHdTYrmQ7uT9zgkPPAoIotAmvvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9R14NaI/JeikKnHJ+yahYnsuQHAHuBELGNZM0uMuvo=;
 b=iUyo4VuMYoeQDbQBop67Xcym+JjYL2KnrAni6P5K1KwrO2QE6btapCB1MSj7TKe8IbvJedrd9nXccVFcZCtCWMs7H3ui1Ojumx379YfAgaz+IXkmcC8QCxsuBZ2E/eVdOs4kMlMgJTjB5m2uQJnnrJFTJolqbgy21Xk0qWi/KvR+LhAApJ7Ix+SG2QKoJfNBn9Di78PNLzRTg5Tnf9/lkkQUtwDmrimdTcQzMvcn4TWrNNGQrkcVtmwjYOzMBravVLSKV9RM3XW3dPYMcUruM9WkuTQm9XRBcHYkLbmwau+ETOoTFNy8ZTc9o2ntO78y31L8Yuy5N0lufoC+mkBO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9R14NaI/JeikKnHJ+yahYnsuQHAHuBELGNZM0uMuvo=;
 b=estdNcX6ZWle4oLQWsI3DceVoq4P9PtQFZuEaPjLIUCLj8/z69YbVgUBGLNZYophyM0iZVHIlWX8gEQe3lBVWX8VyQJ4HCoAatZKZ3B7zveZ2+mgA905STALLRqXxld6kENJXR/O5Lvgw7rHY1IGJNDjneUMU9sHLxNEBONjblUHYgXa4tXUBZeSGsNJoRUFjQYqmr+7DKXnCCqi2YAVFAJ2ePARbCJX0hjjbUN9oPlmxdRiXqAQgI/1pmwS1pYadDhZ8pljjf/ZJhvrjzMFN5FO1U4VXHlNa/gGNvsabEvRKTitdFf2B8c75E4+cFcpz8iN2DKVMtDrl/x2LjGSsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by QB1PPF9E6EACE85.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c08::270) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:36:12 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 20:36:12 +0000
Message-ID: <042cdb9d-58c8-4a18-ba4e-a3dc8ab028c7@efficios.com>
Date: Wed, 18 Nov 2026 15:36:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] locking/ww_mutex/test: Time an ABBA with both
 owners running
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 linux-kernel@vger.kernel.org, will@kernel.org, boqun@kernel.org,
 longman@redhat.com, rostedt@goodmis.org, clrkwllms@kernel.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 shuah@kernel.org, juri.lelli@redhat.com, linux-rt-devel@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
 <20261108141347.1525532-6-mathieu.desnoyers@efficios.com>
 <20261118163807.75hxTxGn@linutronix.de>
 <e57bdae9-4f87-4cc1-9fdc-22c2d766e252@efficios.com>
 <20261118184524.Vxz_-nKr@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20261118184524.Vxz_-nKr@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::23) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|QB1PPF9E6EACE85:EE_
X-MS-Office365-Filtering-Correlation-Id: adb59fd7-15f9-4b55-9ca4-08df45b395bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|4143699003|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	mxHUzuY6isQ87MJRAzCSjut/CBgy15h4Ftl22AdNXVcCMEUE3gaeHOg+EBKTo4NujU/0T9tVG1x2Mn5V2pjoLkgfp50Jnej4XMgY/aUCIgBsyHSGpSIEM/FrYlMxDTk2kGy4F2GgLsaqBJ0G8Y0gv1kpAUHbXbqSzfO0zvERXPCMwBj/EgYIiOkcYbBFjI88ksG1oNFpXFO39V9K+tMhTBQ0s2ejwhb76RxhAJX6FmDbJdf0WWQll3/I8EI0x8tjfTemIXcWwv/Rz8QX4tAwu329bngqF2jkynbjJWkUWUoBwS3gQ3FpGpx+YCwB9ZTnP4zLfy7sQIilYUV9wKb5IAGYUyQeoijLzTK+aDRmK0x6oRROCwA7sfYHqLtRIxMw59XjcPcHwrzHQIYDWREGvNa2Hti6VLJZ8K5M4NQQWa6TvKvHo6OskWBSlenbwWs6W/xYfWO+tB7iAb618MebZBlMMB3s66odrZ/tFXZaT4oyQA+WcKum3wsWhu4/6Qp3pO2t0ZDlnArILfLGv5qXZZpTLuGDhaM5g8DSdyszhi9vUcZcKuus+pu/PPhFj7fDV7mdxNKbI42w/wQPcrVEqR7De5AXY7mMPcaJ01l3BV8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1Y3a1F3SVJEVE9GNk9pOWlkS2NCTFdYL0VLeW4vMzVuemVGTTl3QjBDV2JO?=
 =?utf-8?B?djRNZDBiSTBPN0syNk1SL01oMHh1anlESUJEbDFqVkFEcUNNVVB4RjdNOU9C?=
 =?utf-8?B?SHk1WU1nN0ZCbzFpZkw4NE5kQ0N0SFQybms1NEpxZ2V2aHpsSVhMQmV6cVFX?=
 =?utf-8?B?eTI2aVdBNHd0MTFlMG1zVmovN1IrQUZoaGtpQ25iUkpOdk1sTk5TdThoM0Vh?=
 =?utf-8?B?b3hENG5FbnArN0RSVnlDdTNEKzM4M0RCMFRycGQ1ZDlhLy9OOUlEVmZsQTVx?=
 =?utf-8?B?eW42amkxc1p5VjF4aWQ3QW1ZZjh1SmowUmE5VEgwMXFsdDZzcXdaR1FiYmo4?=
 =?utf-8?B?N3ZpY2dqSk03UUFDWnZNY25NVHo1MGZzeVBUMTh6d0F0RkxJUmpOR2JuejFJ?=
 =?utf-8?B?TjFrTWRKUVZiTktVTDNUQ3U5UzV0eERiS0tMQXpja3I4ZjF1WG1ETFdUNU9o?=
 =?utf-8?B?NEEwMTZSQm44YzlJdHgraE1WbHBuR3l3bG04OHpuTWpZRHZkdHd2TGFWOTBH?=
 =?utf-8?B?UUgyeGxFNjVpVytEdU5uNkRxTy9kVG9iMkk0bkt1cFdHSjhiZk96WE9xbk9u?=
 =?utf-8?B?R25IOW10Z2NkQThIaXd5WkU0TW1MbXB0aWlZbUxYZlJyd3JDOG5tdjgvb1ZB?=
 =?utf-8?B?N2pVZGtFcEd1cTJSRiszRW1qR21YMFJkeXVDbXkzSE5wNWxlQ1E2S1JadURh?=
 =?utf-8?B?QmtiSnU1c09lRHZ5YytKRWdBTnBRbkpQbHdiTDU0a0VtWXVwaEVubXdEdVVh?=
 =?utf-8?B?Y2xhZGlvd0V4czV3Sk9jSGpXY2ZwN1pTNjdaUVlXazFzVUw5VG1aZU5jejY0?=
 =?utf-8?B?YXMwQVNIRVJwNVN0WTZMVjAvS1NtVEF1aHR3a0Q1K1FhMklFT2pTdDg1SERn?=
 =?utf-8?B?K1JKM1VrQTdyaXJScFNHTjJkVWZnWFZNWE5TSWw3bG52cFpGajczZG9TcFIw?=
 =?utf-8?B?U056SUY4OTN5NXQ2OFJHUkRnbis5KzRNZ3JpcHZDU1JueHZJTEJkMGh2c2dm?=
 =?utf-8?B?SHVsd2dwTkxVdXJlMWdyMDV4bTVHdGpXcmZ2cmoyRzJlVTVid2ZITkI0QWcv?=
 =?utf-8?B?MHNnM0thS29HM0hsQ2E1eTBSRW5VZDVKTHFwY1Z4eTFKMnFoMmJqa2x4angw?=
 =?utf-8?B?TlRnQmRaWFdlTUZ6WkxjVzE1LzFCbUw0ek50azlSOEJ5VHJMS3JwVlBSYjVU?=
 =?utf-8?B?VGwxU1FKZ0pWK1JZLzJGVndmV1ZsbWxVL3dIWXF5YytaUGdDNitPNzlmcWkz?=
 =?utf-8?B?UTE1Wmk1bzQzOFQ0M2YzanM1NTl2Ykd4OUF2azFxaVNKV3RnV0ZNNkdheURw?=
 =?utf-8?B?NncyNzVuUE5waUowUDc1ZjkyZkpNV2s2ZzB0TTRqSzVEYlVZbEZRMUlsN2Rv?=
 =?utf-8?B?aS9HRDROVXFCWTMvQlBMSzZhby90MWVocUNCZGw3Z1B6T3BscTErVkFVVUth?=
 =?utf-8?B?VGYweFA2VVVOMzdDQ0VISDlDZnhZMUhFQWdGbkhBM2FCRTRvSHpkdG1WUHRs?=
 =?utf-8?B?R1RPaTRMbDNMNnByWXpxaWJzWitmZHFpQm1uenFCbmpQTDFIc1gvMEhVSFFR?=
 =?utf-8?B?VGVzMzIzUFRDbnFQRjJ1T2NqRXkyMjJ4cCtuWkwwamR0UU9UeHExclNlRmFF?=
 =?utf-8?B?ZnQvUHlyaXNGeS9uYzcwV3ZBSHJraWx6MFlZOHZSS3BqaUU5aFUyRk83ZTky?=
 =?utf-8?B?Vk0vOGZSemRxWEppd2JQY3cvbERpR2RYQWdiNUlpTTRCc2ptM2xtbWRvSU1E?=
 =?utf-8?B?ejJkNnJBd1FEanhySzgreXp5WWM4VUNrUSsvV2JOUFBCQ2dHRk1MQkVYN0ZN?=
 =?utf-8?B?ejBub2FzZUd4V0dISWM1UXk5OW9Pb054RTJZTG8wUkJBUm1HR1YvbjFMZm14?=
 =?utf-8?B?UUY4dHljREd3N3NiV1ljUDFVeTFlazI3VXhPQllmU0ZjS2RpUnZaYkRQTHFP?=
 =?utf-8?B?R0VqOTZpK3NMVVFqWTczYUYrWU1BdkFMS2c4RVE0QnlhRHBnYkQ3N3BLbWJ4?=
 =?utf-8?B?N0Y5N3RtbDNGZCt1WkppTm5zZWVNcGxjcklCV2w4R2tpOEtoblpPNU0vMlY2?=
 =?utf-8?B?bnJEbnY1WElLdXhIZFZJeW1vTktLdTI2VC9uSHRMV0hBNkZERVJQSkVITmUw?=
 =?utf-8?B?RXZDbDRyWVRZU2o5czE0UzduamRKWDNLbkF0NnlRSW1WK0oxdmpCQW9GL2U2?=
 =?utf-8?B?M2RCbWg0dExjNXRZRWxlNGhDc3dNT3ZnVTlYb2l5dElEN2EvRS9LMjRMM2s0?=
 =?utf-8?B?ZmlNbG1TalYzUW85cWZFQzdFWElMRzZQNW9NYkpwMVNUMDlEdmw5aVlESXFX?=
 =?utf-8?B?NjhLRDcrYzFLYzJ0MGFyMG9CTHpoaWtzZVdDdEoyZ3hpUm1pazhNc0FwcXFX?=
 =?utf-8?Q?DHLeB90/jyXOkAyp/bs8Ova3YMU0JymzT5D/e?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb59fd7-15f9-4b55-9ca4-08df45b395bd
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 20:36:12.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsHL1zUegEDrVymB0BycJMGerwOOot0WwEyP+AGZc8Xt5wfTYlyi6ME/nPb/nI+IVp28pXlWsM7ac7Zk8/BrH+RImKv7IWbiSTo4C93VvZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF9E6EACE85

Hi Sebastian,

> The timeout that was introduced in commit cfa92b6d52071
> ("locking/ww_mutex/test: Make sure we bail out instead of livelock")
> triggers. That is not related to your patch.

Thanks for tracking it down.

> I don't call the shots here, I just explained why I don't see this
> needed. We might want to cover this code path if the paths divert in
> future.  I don't know.

I would keep it. stress_inorder_work shows the bug only through its
timeout, and its margin depends on the machine. This case times the
ABBA itself: 950ms without the fix, microseconds with it. It would also
catch a change in the ww_mutex path that the futex cases cannot see.

The next version keeps it, with your Tested-by.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
