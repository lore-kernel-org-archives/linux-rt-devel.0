Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795008929;
	b=0bmBE7oHuBe6bQF/wJlm23OcWHCMeA23wsQBXekQmh3z2nm2i624gA3qk/zC0tXabODK
	 KEfKxsB5ZyEXfW0+6LNFIzsEC++tmJYi61ifJI2FPS6tR/SRUhsrPNLVqF68/Bl8maGse
	 /6i6cw01e3TZLcR6BpXKzSkOv3YVE0k8akTZFrBaMqzhLy5f1i3KjM/Vz25FSo/pwzEa9
	 adIVSSKs0wN64vV0aCGcJx7uDSJzpQ3b4OZaNXyeuOYUJs8qgsFmmPDC8FZSQwXeCBgqB
	 qC1q7BQFYaZf7Rl87weDG9f1qfzdulXUX4E8a4gnRQU3OFQZyKMw3Dp6UZsQJ4jbULQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008929;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=kz6dUiwnwcOeVe+Z6ht7qIKVLgnbyAS10T5d0/Ge6R8=;
	b=YmHHjzrKXzt9Bm7rbLw0fZsLVww56FEsnhl/XuSepgQhy3r19kFCtymvDz5UaRMPAA8a
	 i/pnxuJv0yu4Hi/j9s1/37zPr4sW4mMuGGyh+NE6PLhhz7ZLJvh5c1b1KA3W6ufljLez5
	 Y3XB1rK0BnfMaP8uQYX8bo6aES50DTp3yiMnvOlqanRYolHnBj3/f3Fd3meufWD+4GoGE
	 k0BlKkz3uTNQnRQ7uS7qOJK/+DLG0AVo6m3TXk1wHS8pZw7SKRjPsW7hqMhjWrWKGRfzi
	 wocBMi+0i6Fmbsa3Y/ueWZMBuh2wTsbQwQPYKOE8Bu3S3C0f0mmyExeV5MK6Mut5COg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.134
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020134.outbound.protection.outlook.com [52.101.189.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278C606A31C;
	Wed, 18 Nov 2026 13:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4278C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqacRVppPnopfuPA36B7T2YgHqBIadKYY8P/s3Ok8LwztNsTShlOt98T+SYlNDwdxoUIMiyVWAm88h4QbCDJMs84I/IRfMsC/NtgK+Bzi3g5QSfFJE2cFtDBu+ZbgW+TezvmaBSVGAaHNzOyjcQUIaB24BMzH7+P862v6r559YkAkOTqmA9Z18baQn3iVDK+GvcviYkrJmJ35CFpizgAWf0uYK1DLVnPXl+FyiXLmHT1z2vg0+t+UOOw6yXulF/OkRDME0a7283p8hK5sQP6LS3VBYKt4JgG/joyU9fOnsKKkK1E2SJQavXWj2dJXNQ9yX57Jpa0zVucvMuVOLJ6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz6dUiwnwcOeVe+Z6ht7qIKVLgnbyAS10T5d0/Ge6R8=;
 b=LGLDbvhZf3Lm6o5s93Nj0ZUMFRo8EhqOXnacfW/yA74g7nYPCbOp7RodTdm/NygSLYfh2eiFwMMkoSFqg0tCV+japz7BLPW/tr7mQ6rSBQ7DhtygNfU1Oj9ji9RFgpGf442DmnZkvLF7sDGxIYutstuj5IdJmw19BJ64P+VbDvDXMBCTW2pNjqMjHCE8BLZf8b8coUZyFDcva1KskOqsAfHi+y2sRYb7jdCgpP7wBNTYu/Bu7AlScl+fng8DFC9wDkMRtoA3iD/lGd+vXuItp4qs0Z2uRVT4+Xhkla9jGgWUtrD6IAdNXzLazSROagaOFkYw6eGjiL1l1HynmWFz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz6dUiwnwcOeVe+Z6ht7qIKVLgnbyAS10T5d0/Ge6R8=;
 b=H7qffdbquUhxk3LTKaIxSyz14LnJWXprlwPnxjk8gm0CVFVh9UkSd/szF7H4L0sE6dRRbNRvzq0+/21ynC7DX3qRGt6s08sBsXdtfDuUQbaw1JYnpeCw22noisKGmrvEeXU3t/d1kCct9rp0GrNfCh+ccOA1gasDyyGf0IZP73crj3Mi2C+Ymt4h5W2e5ab3Xdd8VtQvpzAD5/HV4qsOgWouU0DUwAEs6Tye5iPbhgh7im7qiMmkrqA3q30CPDCMugmfRh/AA5WzjFtRHrvSqzQUGiMYqHc6KiXtOXXZuE/ZbbYkYC4RQMqYUt0Xt8BhGSrkAYyMTNFOHY3YvdqiCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQBPR0101MB9677.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:80::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:35:22 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:35:22 +0000
Message-ID: <f535fbbd-2247-4d0d-9771-a67116fda1a2@efficios.com>
Date: Wed, 18 Nov 2026 08:35:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/40] rtmutex: Continue the chain walk when a waiter's
 deadline donor changes
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <c8b228501d8981454f63843b394019fefd4002f3.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-218990@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-218990@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::28) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQBPR0101MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e51a9b-859d-4fe9-4f1a-08df4578cb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|261022075727099003|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	URxTr2fqxgwejmCYzoAQDwrAS9nXsVTY9pqLgoxw1df9KOLorMC+xm3vzStmMID1i2s2+K+NDN18srC1QkCvOjvUZd2rRgfXRsRQ9P6oef03NRAnND1nAq6LX07LiNIjqcS7Z4J2efQpbcFgnxCLo/F/OVCOkRAO+i+oh+YlymQXQGc5WmIinKrJ5xvNcuS7C8t/dBuMfNE7sO3hOpGl50X2o3DylGHaNx17qPguIgz797sy/J13J1P+6tPXTg4O7xVAtC7SmouVHKLV6D0u5jJIrkNuHeoK9my2IUvlE/G8IMrVnh2FikieaTQtZDhINPLS+v1V18CT3sPN4L4LFWS0zGdo1kAmUo1T8jJ4BT5JrwfQ7D4ZmF3b9NT1AE6E71wuV/f9fiJI6PE0lu+wEMV/EK34jpfCYlHBBoVSxzboc9lmFwIQ/UQcgcai0yjxZKBRe1qfybqwXd/OtjUjToQa0cNyYEYmymH8pEt1y63RgpJKTnLbOITwGGEyvO56lf6WXOBBHPCUZIzLtQsdOTM2QYWUy8nZfQmpzDIEryzZOShfnbgDtWFNYPnii5RqG4f7UnulpEtP7ouRh3B3fM641uIJgUa6g50Y3Z/9TSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(261022075727099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGg0OTdoalBEMURaRWc3R3kvWVYwSVR2aWZ1SllkYzZHb2RUN2tsallQRmJy?=
 =?utf-8?B?SG9ja3ZNekNsalZDN3g5akFLT3BETUErSDl1Q29kemVlWE9HT05kT1hoUnBh?=
 =?utf-8?B?ZUVlOGV1WUdlc3NZR1dCM21seHQ3dm5pa0tMNDJwMWVWOTRCYzBmYVBFeXRm?=
 =?utf-8?B?Mk12cDgyeEdzVnhyM3piUzdEYXkrNjQzZm94Yk42dGJMYnFPbnN6L1I3MlJS?=
 =?utf-8?B?cmlWalNVOFZHVEYvRTIwNStnOGQ3Q2dpYnZTVzhha2R4akF6ejc0bjFKY3E2?=
 =?utf-8?B?TFRpUmp1RlRsSjVCRG9TU0d3RW43OW9uS3FKMG1zcnR4VDF6MEF3czh2UENn?=
 =?utf-8?B?UXZzZ0xRY1VvNU8xUmFKVkk0eUFiY2dEMktVMjBpSGkrUm9OWmhoUlFBRlk3?=
 =?utf-8?B?YWN3aHZQV0dWR20xZXJ1UkErZWxteStlOW5DVGZ1UDJHRm1JZXY2SW8zVXVs?=
 =?utf-8?B?YXN5MEZPeXY4em9mcUdjL2RaMDFaTU0rbVJyUTV0OGJLTHNlUVRQVXBzd0Fo?=
 =?utf-8?B?bE4xQmZNT0t5aGt5M1pKOUVWNGg5Zk5YTWRETG1LbnhqQks5VERWamovejA3?=
 =?utf-8?B?a215WUdsdWRiR1QrTjFPUVRUa3hPR1U2M2pwRE5EV1RKQ1orK3FOV2p4N0t0?=
 =?utf-8?B?b1lhbS9CNmRtK25QR3hQdmNLcmp4VHVqc1JtSHFQLzA3d2twRno4NjcvMHBO?=
 =?utf-8?B?YldJbmlBRElJYkovMmdiUitDV21DNm9TeHExMmErTjV3VlU0b1VYcHZLWm1Q?=
 =?utf-8?B?MEk4OE9kK0ZoMU1VT2lFYTZYeVVKSmp3MVNxTVdLQ1VSUkxRM21nNGtVdWlK?=
 =?utf-8?B?ZEQxd0RlazBiMS9zWC9pTWEvT1pXRjdScmpiTWZJaXNxQUFtSHVsUDhJWTVn?=
 =?utf-8?B?RStOa08wejVUVUZmekxCTVlLazRBTTJHM0hhOTB0QWNYNGRyeWdZbWNMSUQz?=
 =?utf-8?B?MzFaMlVnK2srM0hCeHc3T0NuZEhteFNDT2xwd1EvOGUrOWhlbnF3MmlCa09Y?=
 =?utf-8?B?d2QzV0wzOTRqOFAwQjZUd25yci9NS2RmdStDR2l2Z25Fa0pETzVIcGw4MSsz?=
 =?utf-8?B?SDFxK3NCaEc2cW4wSXA5L1VBUWlEZFpMQmtBQjZhL1JsTk94ZGloUVpSdFFq?=
 =?utf-8?B?R3UvQ1o3bEJaaTlUWGlTK3dldkF5VGZ3djBPWVBpbXYzUU1HMktpUjdVWFFs?=
 =?utf-8?B?TGsySFh3Znhwd1BlYTBla3h3UGIyQ3lRM0E3NHRiZGdJVHhvckxHeXdSNE1r?=
 =?utf-8?B?NzJCMXNnd1FMWFZEUTJhd0NzRWx6RGtNWWtQL01xV0lwTFNjeUdrRm0waXRU?=
 =?utf-8?B?M3pLWlB4MWZscWdaRXVaaFNUZ01LZlFOaTFNQWEzWmx1TXh3UGUzOUdkbDFs?=
 =?utf-8?B?NHV4S3RXUllaeFF1TVFUNE42OXo5TkdnaHdsOUFBd1F6TDNVWHlKdk9IUDg5?=
 =?utf-8?B?NzREeVpxSysyMkVDLzNFWHNsckx1cldkVmlpekRuUUpqS1dTNzVVYzNuWFdX?=
 =?utf-8?B?dGhjSzR2Q29PcktOZVpHbXorM0ttOVdReVVVRm9iUnE5NnJqNlNGb2RLUCtB?=
 =?utf-8?B?eG9vbW5tR1dUczZ6dGNFSmRFR1ZjMnB5cGtnNUdLTDl4RjI4NW45SmdMTWw0?=
 =?utf-8?B?OFJmMldHVEZkVU92VlhiWWlEazUzSUxBcUxPUnhaNk1NN3grcERmMGs3azJw?=
 =?utf-8?B?MmVmWnhjZjJWcmFHeUw0T1RKWmdLeldKbXFuNVJmQ1I2ekpKMkdiSTJxN25M?=
 =?utf-8?B?R2lLRWI5Sld2a1ZzTUxkRFRVUWRkSk9mandzUXZ6bkxsTXA2WWg5bUFSV2Fy?=
 =?utf-8?B?dHZibXJ5Z0tHMHBEMEE0WkRhUzNYTnk1UHJyaU5JdzZVOVNJdm94eGkrV0VZ?=
 =?utf-8?B?Wmh6eFFURW9xM1NiVTNZeG10NHZ1aEs1dHVPMjlpeW5TTDUvQUNjZG41YmM2?=
 =?utf-8?B?S3VHcUs0dWwrM0JPaFl4a1ViNUtaVkNsWlU1a1Q2YThGZS84aDZNZ1A4bXVx?=
 =?utf-8?B?L2t3cFpteTN3cGxOamZCeGhPZjJ6b05qREtpMmZPcUNTeXZpa2RrM3F2NklX?=
 =?utf-8?B?RzZVNFArMm1mZFRWaklxWDBVTHJlTDJOa0VWaXo5Z2pocGNDVmQwTzlKVEZ6?=
 =?utf-8?B?YUkwWlJtUFkxSU1EWUVXaVpObTMyRlUwWXkzVnR4SThhQzZ2TG9KQVRvYjZV?=
 =?utf-8?B?NXpEM245elp5eVdGTitDMFUwNVBza2U5cHZzMzFzdGIzUUZqSHRmN2VkUXJp?=
 =?utf-8?B?aWx3UnBiY3RwQUVmU0c3VHE1bjJ4T3dKWjE0QXYzSS8rTjN5SFpBOWduRnFu?=
 =?utf-8?B?TXVmUE1yVFN4MjBBSldhQTBSeWUvandEbmpGdVNiMzI0L2ZYeEc5VUU3TnBE?=
 =?utf-8?Q?0kEl8In1S/UV7XUToLqLvOivnbZW7DTr9H8He?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e51a9b-859d-4fe9-4f1a-08df4578cb7b
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:35:22.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9p0YmInToqyXRLfCadt7A/2ZwkTgTXJDmzJTOMoJ9a6OwbuDJBNljFlyFe9fjfm7yYVW1V98IWCTUEGW2IyoVeqCkUOLcAU8WaH/AVkViM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9677

> Can rt_mutex_adjust_prio_chain() still stop one lock too early at the
> preceding top_waiter != task_top_pi_waiter(task) check when a task
> holds two locks and its top PI waiter switches from one lock to the
> other?

Yes, thanks. I checked it by reading. The walk stops at M, at the
top-waiter test, and never reaches the donor test of this patch. So O
keeps W as its donor.

The test dates from the first rtmutex code, commit 23f78d4a03c5. With RT
priorities only, it stops the walk the same way. O then stays boosted to
W's old priority until it unlocks L2.

> O->dl.pi_se remains &W->dl, and once W unblocks and exits, O's next
> replenish_dl_entity() reads W's freed task_struct (use-after-free).

Not in this exact sequence. W is the top waiter of L1', so its timeout
walks from M. The donor test of this patch sends that walk on to O.

A third waiter on L1' gives the use after free. X is a SCHED_FIFO task.
After W's policy change, X's waiter on L1' sorts before W's. O, M, W and
Z are as in your setup:

   O         M                 W                                  Z             X

   locks L2  locks L1 and L1'
                               blocks on L1'
                                 M->dl.pi_se = &W->dl
             blocks on L2
               O->dl.pi_se = &W->dl
                                                                  blocks on L1
                               sched_setscheduler(SCHED_OTHER)
                                 rt_mutex_adjust_pi(W)
                                   M->dl.pi_se = &Z->dl
                                   walk at M: L1' is not M's top
                                     stops
                                                                                blocks on L1'
                                                                                  walk stops at M
                               times out on L1'
                                 not the top waiter: no walk
                               exits

O's next refill then reads W's freed task_struct. Before W exits, O
keeps the boost of a task that has left SCHED_DEADLINE.

The next version adds a patch after this one, "rtmutex: Continue the
walk when the owner's top waiter changes lock". It removes the
top_waiter != task_top_pi_waiter() test. The next test, the one this
patch extends, already stops the walk for a waiter that is up to date.
An out of date waiter is now requeued, and the walk goes on. Its
changelog has the diagram above.

Two new test cases cover it, without the exit. In
pi_chain_top_moves_rt, W and Z have RT priorities. On v7, O kept W's
priority in each of 14 runs. With the next version, O follows Z in each
of 14 runs. In pi_chain_top_moves, they are deadline tasks. A deadline
task that shares O's CPU lost one of its periods on v7, in each of 8
runs. It did not with the next version, in 8 runs.

Two more points, both found by reading.

With the test gone, more walks go on. Patch 33 started a new period for
a blocked task at each boost, even with the same donor. Its waiter was
then out of date again after each step. In a ww_mutex cycle, the walk
could run until max_lock_depth. In the next version, patch 33 starts a
new period only when the donor changes.

A narrower window remains. The old donor can leave as a waiter that is
not the top one while a walk is in flight. It starts no walk. The owners
further down keep it until the walk in flight reaches them. The donor
pointer holds no reference on the donor, so no change to this test can
close it. The cover letter widens its known limit to this case.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
