Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924924;
	b=Dx7xHH8Rzazj1KNTeih10fMa6dPs8VOBlojaNoCIOctQJ7zsXfnolqCQKAR/9kFDiDKW
	 jzakW5F2eJquyH0BV1jEZHxFtIdR6yKzDLeYY+a4ODUfO0A9NEfMRpJ4fBM2uCW25Awkc
	 gCShfIMyof/qR36Z14njWtl+WaLx+o5kAhMX4abkPXbfwtQuyJLb3k7mnhbVGIbufjHFa
	 lWQbr7cP1Is4xgHt3/0/vjxFLGxDqO5bOPd5VIKkRbcPirQB3llkLXTE4UxOTvEUf5Z62
	 RXQPvuSX+BPUg7tek/q38jElvjwdkfDOpujgyrcw6Du3Klms1X/RGqbGSzgVyYP+cIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924924;
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
	bh=qXJVVJiA9TaoQslz3jafWjkC9oo7FGfOtE5p5gY4k/k=;
	b=RGxLaz0HZ+UfLR9ElIwxdKkZ0w5rvZ2Gx8RH1JI41YCgvfne9j6oM2BO3VZ9+xbhWgdg
	 RwKmAOlwbGRpATLsZ0uTpRTbT1NBTbUkYWStx9ugLSO/XHT581wHfvCUTW6h4Md3RBrZu
	 MES9JZLoGB3dX8gucEYL9OummB5FHEMSF6/tPsr/eMP/yUB5FGn3lDliB0EbZtkIuWsYx
	 ldkkyxE7qc/cuKwfxMuPDO4xa7VQOzw09E9R22OVXszNRg+q/PPJvnLPLhwhNYXJzhqhw
	 hnOOeeBAcjLZRx9DSDZC6+VQxkrHJsoofmA5o44Pm+oFvQkDmIq5QOiqHnU88PnbvfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Om6fApap;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.123
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020123.outbound.protection.outlook.com [52.101.189.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701B606A88D;
	Tue, 17 Nov 2026 14:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5701B606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Om6fApap
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgknKg6jTgI3BTz3DW59HIQ4ljr/z8OSFavRMMWQUzwC9XKyaXxqmqNRje/wXHIcAMHK6ZRcqYpABoX5Y/+oOHgqFJcjhDIXs4sFCWbPK2M+4WwBkrbe1Mc7C0aY8Nfg4sHDa6P6duhjJaqpbxY/Aap958y89mTjGnH3/aLvW1tTPDVR77baJ3AlXDd0sCXD2W+t90MO4tVfA2kQ2TO/xZw5DiRUcOq1XKv0PIxI3RC5am00UpBSkQFv+zyNcIeCW7lHbixZwBZEmuW8+jWyJLbYn4JFfzMTm2oX7+m6jRcspgLcTskQ0hV8XCd9xxf14HGwxCW8gIAk+6jyHm3OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXJVVJiA9TaoQslz3jafWjkC9oo7FGfOtE5p5gY4k/k=;
 b=L5bbIC5e4IpKUr7set1EWsdVh8bEVImsbfP+CQFZz2lUGlR9PdrmkZ3eHy+IL4ff8CW4P+M3tSIq+RrROXm7Lb4DZtYXxMc0tzMQqauYYIfqFbYMtxkNOsse9eGfzv1J0w4yAWdVMkQqPouWVbPj9FWcMmCshAzTspqln/49egeq7LQu4elDwZgQVhPDJYBXSOfCAoRWgYfOui7D+Tl54++nHGCygbU08RXyd+hoTvhSc43qVHeP/0lmwqN5bXZeJDId85ey/YJ2ioeXUfXDMwP6nthB4IdLbT1qfB4QIwTITk9sl/dFbt9Fi2e9QakTf/Qvo1esKKFel/P2w1IEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXJVVJiA9TaoQslz3jafWjkC9oo7FGfOtE5p5gY4k/k=;
 b=Om6fApapgVTyqrZ2JORdLHNiFeO1+vvOdihnKl1+GTl4hhUiot5mS/hOAIFd7XYRZBUIQ/83R9dehFySoTtv9XBsdT7EOKeazpVttcCXdK+U6+52V6asGdNfZNrVcW7CtBP3Tsbj2WyHhOe3YVma+t69SrlWPBhX6oiKQNoKfCjlMGoQEkhN8yHybST8mX8QZedvSF8HYlcHR4LqBNZ7l6cnjJ56j010UFOyQBC8Fkz9+PIDbv6GlJ4j4sEn2qrfajEvmx8kRVt8dC64sXrfsr96PZqy8VovDiOgB2nIKIs04sKsJueDWtroz8bnXGWtJjYr9uANQaXUq7r0CyDOZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9777.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:15:22 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:15:22 +0000
Message-ID: <e996bc71-3b2b-4acd-b0aa-176e8529d38e@efficios.com>
Date: Tue, 17 Nov 2026 09:15:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/37] sched/deadline: Reset the donor's runtime at a
 deboost in the class
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-11-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-217586@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-217586@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::22) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2b3215-5d09-4e51-b752-08df44b537c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|3023799007|56012099006|4143699003|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	AvcPEuejxeolcGkvC23g4juN2NpdAI1dbvLq1kPqUFPVi7edXXZ/5WmkaqBWlOnEArCZ3tXnMy4LxqUl8Iq/dhiYwpqrKwsJNLxrzYJqIdmw6bwfNGVQ9usrcv6t+FNHgZvZR9wLz0NChCZWU6B76uWh60I6gStpCxhshjrssUna2y2XoNHRRjqDsb68UjfQhfL0QJQ2rJ3DI9+cryXKoAsNsy6D51XN+nrp+TSc02u/wNrvssAkrNkWX4OTvFOgsfWPgqPdbN009UVEvNxrcnDVQPI3Lv+O4ePb6ZELFN/T7A8Tjj+LFmbC30MFR4hlgNcykrT3Mfg1CfwieQx/clnZDthptxWVab4QFLFMOeKC8iFtve8QxeRzVGWgqChypYDqpt1KXjHvmizOVitnw4bIP1Jncs172Q3k690aEUH+ULOQUTgTpM/bOKnar8VkzzYKqmXWZkXIozRvPT4KC9TEar2pgXswOQjAbBNto6cX/SZSIgfdqHv91KBX57YJR6novKtX3TWPN5NH+sFLH5zzvyHqHunF7Q0/A+yEhJ9I6ShKNzBS15eqOhExJE0UAUBKX6I69QGvjhttFj6rPc2Q8qhGUjbif3HVSWUPxHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3FWSWEvUjZPT00za3Z4S3ZFRlVvTFdzYVk0VTg5VXNGNEZxQWdhaE01cExX?=
 =?utf-8?B?QUdKTG1QakJXUi93NW5VQVBXVTVzNjFTdk81SThFc0V5eFBIcWtFdTI4VkZW?=
 =?utf-8?B?cE8yUVpKUGlDYVdvSXR6Y3FId2c5RXdOSDk0SUtUWE4yTE1QMkpRSHpiODF4?=
 =?utf-8?B?TTdmTDM4TE9sNkkxVjdUa2NFaTVEYngwN2E3bE1OT0wyU1hkUElGRUpIaXVS?=
 =?utf-8?B?cVlpR3d0YTNkT05SQjFHdUw1WlUwNjNIUnFPOUFURG1jL1VIcGRoV3JiYXhv?=
 =?utf-8?B?MGkxQXEveC9VNlpRKzNTTnBkdzNYOUdrL0wrNnpOR3JaTjQrU05lMUkwWVFk?=
 =?utf-8?B?cUk4ZTF0V1NuVGxQWnIvT0EzY1lyMEFyZGJXZGcyekVUSE0ycUs2NkFhMFN6?=
 =?utf-8?B?TjlBMmdGVXN2VnJZc0plV01TNCtwSjFERnhBK21nR080My9TWXQ4Q1FSOWlL?=
 =?utf-8?B?bU5xNnBHOUZ1WXBsczlmZEtYMk83S2xiRW55NEd4bmxvWkxzQ21iOFdaMUU3?=
 =?utf-8?B?VVQzOVRsMDNTM1M2d0VwMitja3pQekVuWlJvOTVoNVZSZFNpcGJjWEVtRFFE?=
 =?utf-8?B?cGRJSzh5ekF6c1dJNUZKbG0yZFRvS0kyUkdMRXd4ZVdrSnBZTHhWNUg1Zmpx?=
 =?utf-8?B?MjgvMnVjSncvRDNwOTgwTTFIckp1a1NVaDNNdm85ZmFEdXZFQTRrd1c2UGo4?=
 =?utf-8?B?NUxzN0oxWDRnZm9RaDMxejdHYVpmRVRhVjFhbktWTDJHdFBLTjJoQW1yZnNN?=
 =?utf-8?B?U0N4VjlqQmVvZUpsUktTUGdxR2RMWjdMWmZxNEFXZTVRWmRXejJtNXRoS3Zv?=
 =?utf-8?B?aVRvcnYxTkVsSER6LzI1NFpyMCthN1hGQUlCWk5JTVZxZVBSVFRNL2dtWFVF?=
 =?utf-8?B?T1J5NTdtZEh4VnlheDJlRjBTS0d2Y2lVZGhWM1l6RkNONnpSczdESmVTSTJN?=
 =?utf-8?B?SHhiZmlWT3V4cCtPczZIcFhhWERGYnZaczNRaWw0NzlOSCtaaTdKUnRlTXRp?=
 =?utf-8?B?QUZjTitXb0R5NS95dUI1bnZSYUE4NVlJdjdxS3BHWUNYSFFGZnRtOThmUnlp?=
 =?utf-8?B?WThUSjVnZlJETVF3UG9CcTE5TVJ0a0hEMFZEYURHdzhBMXVRWDE3VXZ3VVVj?=
 =?utf-8?B?anUvdXBiUmlJY1NhL09VeUpsTzc2M1Q1aFF0WUtTWUdZcUR5b0YrdjB6aGk3?=
 =?utf-8?B?Nm5MVlFqRnVnZGg3cVhRYjUwc2NMS1IzNEQ0R0ZLUUNFb1RxL1hnc2RzTUFT?=
 =?utf-8?B?dnhiOUdPWXdoMis2UTU2dGN3N2dtWTF4ZGY3N2xHTFBRdXhGTlBldzd0MjF0?=
 =?utf-8?B?TkdsWC9FYmhndzQzYlRpNDNCeDRGUjB4bFRmZkt3Y1lEK2lkcUkwazRDN2wr?=
 =?utf-8?B?SUVHRlVMS0x2WHA3WVBJLzBQenhPMzBoZmR5OG1EZ2VRUXYzbVpEeXBocldB?=
 =?utf-8?B?Nm1nY2lwRVRHTy9rM2lpM2NKdGRGbkdVK1VybUtIZXFmK291ckZIemk3R0pY?=
 =?utf-8?B?N0wreXprZ0JXdjJKeitnSjNxbjNOalpVUWg4WjVHTjM5MDdONDdBUDdOQmha?=
 =?utf-8?B?dWpqWGZjeFlGOXFaUHR5Um9XWlZ3bTJEQW5iNTN6SDRrSWlGZWM3bWlXb000?=
 =?utf-8?B?ek00NUpielljcXkyV3hpRDBSSXZZQnlQZzUvakhMQ1RTY0hyNVR5TXNoNGRO?=
 =?utf-8?B?TXR1RC9GSnVXOG9QZ215bi9ic3UrVEI5cExFb1JUYmhPM1hLdEswbG10a2NP?=
 =?utf-8?B?VHdLSkZEei8zV3J3YWRCWVI1bnFuUFVNS2hoT2VkbGQ4SXNtYkNHZDdOZzBq?=
 =?utf-8?B?dlpyb25KVHVMZ3luU1ZzWHk2cERHS2oxaXBqUGRhaHdCdHU5enhZRmhoWnFa?=
 =?utf-8?B?YmxHT21pY3RTY2JwTk1MOGVyYjVaOXRMVFNpMitWZi8vV1lGc2FTTms3RUVW?=
 =?utf-8?B?N0NWdmtnaFNEK1hIWEovUjdaamFQeXVSWks1OHA2Z3h0cUg0TmJNOUFsaDZp?=
 =?utf-8?B?N1RTMTQrcS94Ym16MkxWcDBra0pFY0dxYlZTMXZBSlhTdjZZZG9hOURhbXhS?=
 =?utf-8?B?U20rc1pOY3pObHFKeEpNVGJ0Z1RXRU5US3V4NzFFa3Nkcnl6L256RmYxYkNn?=
 =?utf-8?B?a3I2SkxvNlhPNFVMS3Mxd0E1NlIzSyt3OXNWSWFMTW1UOVJoemVjSExIMCt6?=
 =?utf-8?B?aUhwUDROOGtCb2MvTTZXcW8xc2lOYjFib2VIYW1qYkRmai9FNmN1NTJpVnZt?=
 =?utf-8?B?OUhBWU12QUU5TWtMa01WencwQUYwdUszUDI4U21xUnByUGgrYXdtK2NDR3RV?=
 =?utf-8?B?S09uelVwNktlNEJlU0pkMElsOGFYcTVJMjg4NzhwUVAyci9GTEVFSHdNbGhV?=
 =?utf-8?Q?OnXGHyrz8NBi2GV3y4keQdbGRKeVFhsJOs8y+?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2b3215-5d09-4e51-b752-08df44b537c3
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:15:22.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEos2XT1BHQ5KJ4sWWiWOltofRJYDKZvQfZ0T0Wb7jdbLqPv12XDzYg7wmJ94XIkDkDs/jM71nAbsASjV0QI9ZQr6xC+WA38x0YNPn30UCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9777

> If the first donor's refill pushed p->dl.deadline past pi_task->dl.deadline,
> rt_mutex_setprio() takes the first branch and skips dl_deboost(). Because
> p->dl.dl_deadline is non-zero and p->dl.runtime > 0, replenish_dl_entity()
> leaves the first donor's remaining runtime and postponed deadline in place
> after the unlock.

The first branch does not clear dl_donor_refill. The flag set by the
first donor's refill stays set while the second donor boosts the task.
At the unlock, rt_mutex_setprio(p, NULL) takes the else branch. There,
dl_deboost() starts a new period. So the task does not keep the first
donor's values after the unlock.

A dl_deboost() at each change of top waiter would give the task a full
runtime of its own reservation each time.

> task_non_contending() then computes zerolag_time from the donor's refilled
> deadline and runtime combined with p's own dl_period and dl_runtime.

This is known. The cover letter lists it under "Not changed". At a
deboost, the 0-lag time of a task comes from the deadline and runtime
it ran on during the boost. Upstream does the same.

> otherwise p keeps the donor's runtime and deadline
> with dl_donor_refill cleared if it returns to SCHED_DEADLINE before the
> inactive timer fires.

On that return, patches 32 and 33 check the runtime left against the
task's own parameters, as a wakeup does. Only dl_deboost() reads the
flag, and the task is not boosted then.

> Does this break the build when CONFIG_RT_MUTEXES is disabled?

Yes. Fixed in the planned next version.

> Should the early return when !runtime earlier in replenish_dl_entity() also
> call dl_note_donor_refill(dl_se)?

Only where the early return starts a period from the donor. The
planned next version changes that early return in patch 8. It adds no
runtime, and resets a negative runtime to 0. It gives a deadline of now
to an owner with no parameters of its own, and notes a refill there. An
owner with parameters keeps its own deadline and runtime. Setting the
flag for it would give it a second full runtime in the same period.

> Should __dl_clear_params() also clear dl_donor_refill (or call
> dl_drop_boost()) instead of only setting dl_se->pi_se = dl_se?

Yes. Fixed in the planned next version.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
