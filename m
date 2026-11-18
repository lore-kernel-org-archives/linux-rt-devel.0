Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.96
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009377;
	b=g9H4g+joHh+kBYvXuguuHsrK8CRV2ZBthdd+z0ZHRU1YdT5wC+XFQLhvOjCiauHNH/6j
	 X5/d8rs7naQN8fH7MBJmbsrBM1M2qYSJqnXbWjuVWw8EhlSP22nAgkWJ0EVj7RGzmJr+n
	 XuK4JQDLoQMdzRY7x0LYs8fHXf/eZW3gsDEeZ2N+A2PxwTO3y2Gw3/5RHT13tFvaLb8FH
	 nM8+m/8CLL8w3I4lJIsm/UmLiBMIR89+mZWDLWWDt/R+BxzeogRAb6FgIKPbiRVUH4U+w
	 V8dJCIvSxEGxJ07Yz2vAU8LkVfMPcYUwH/x/LBYRsfiPFgw4y5gRPp7CxvSdSv3Ki9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009377;
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
	bh=1GhJriS9/QIkElDrVq0ifGyw2g5mXEoFlEinxXqzdOU=;
	b=qfEFkxl7rNuXC/HB4IjXs1HOBLmb3N5fmJUrLboIgfzu23uLbDLnsswbovbhknqAne63
	 qzcenhDqbKm4kL6qvHeDYGbOYGjrat24ztBZYJTzMFRXefl9NmhfniqzBerTPddk0B/26
	 MOlzfgzri3CG8O6zfOdsfAKgYqs8TyOgB/ZWc/OYZB3DAUPakCc7nlepj/rqqK9tKQNZ8
	 BzfXBQqirK0pRpVwFPBqYezZktn+yitUBe0k7oCW2flLfRC0p2SqkYbg7uAa4MlMy3mIE
	 X9CyUfrY3j1zTgh1StI6jgE+tF1qCW/tScGye7qdScq/93QWti+yP6jHIopI3fOE7cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jAnPsFY9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.96
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022096.outbound.protection.outlook.com [40.107.193.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63451606A320;
	Wed, 18 Nov 2026 13:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63451606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jAnPsFY9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3b7Of02+EUuk83sQiraGvsTucb5NWNRUbH0gj5eWFd/4i1d2kg2OXQoBqUTgcNYH2IRZSdCBiHcsp2soLJs4wP35qEtKaV9Y9d8cYSHCPfkDYONcT8RmoW80SnUNr+tNSS/zxr/IgV6Pidc6VAmWPLdMHrbSiFbJV0Fu2qtaYsl3ZL4P9wjb8JbTOloo4sUDHXSBOq5KM0f961qJxSQ3sL1P14hc3AAyAdAM9TkylkpJZDjdeElMqNtK11h76L1hPqCNbfAPxaVq3TEjquTEVzL7dv96Ra7m6o6hgwsFwFKsWZoTaTk6Vg/h1aMV/VKYwx4TOGgElsvw9lhmLcYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GhJriS9/QIkElDrVq0ifGyw2g5mXEoFlEinxXqzdOU=;
 b=jbWR2xeYHvtOxcuDHHx3hCusrDeKr8cT25F4W4YtUX6GRxuN06lTUtEuklHp+0H5zdzVlELu7qVGGiHRHd9jtDxjnCBrs5Fu4ymmPR3QiqSCP5mc17iuH9gesqW/CKPVRWOTO3q3Uxfnd4kKpgcB2eq/n/5CvD4fjF/zZGOkbL97hi/n1TOzW/WrtS3HCAxtdcB7TDBsa0JiQvYd45emALrXs2B3/fIpYvlyOoBjH3DoYrEfC4PI0NiGfPIoEZddC5QGz7pDI8DWi5EUsPhTTG+4HcQ7su+Cfz21mSvK7S/CWQQ/NzPgeXta+Ueb4RKBkpWDE0yVuWnr0OxvY2fzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GhJriS9/QIkElDrVq0ifGyw2g5mXEoFlEinxXqzdOU=;
 b=jAnPsFY9zDSXMi30xO2tIO3924/NPlOvWpCvZy7j/I6p6Nz2H5wgwutsiIZx2wfib7RrQsURjwAlXl4pa3HdLMoD4y9h4HuBLeqtEtzi/AtfGXXtBYrdg5L5IxY5lvLi/nPAmJvvkGMFIj4u+mqQ24A0B3RDYBtpZZdLMh2V/KXuRNlLU6QG5y83/zhalQQHBUntz8Du/cGCMnnD2V2n8jCt7DHoWPkL5EzOFAUK/7WaQj21OxChQzUiDuqikGKceTM5lc3jZsLK2rYdHeJ2DNlzlRgUVjo1b0QQBYjBul0K3HJ4gQnA0HH5VhN4trEdgWLa2nay/m8JUJxhOP/77g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT5PR01MB619307.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1b0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:42:54 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:42:54 +0000
Message-ID: <9fad7eea-302b-41d7-a14f-35a32e31358f@efficios.com>
Date: Wed, 18 Nov 2026 08:42:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 36/40] sched/deadline: Check the runtime of a task
 whose parameters change
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <a7e0d6e42bb46c9304699dbfc63dd24efe842ead.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219102@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219102@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0298.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::25) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT5PR01MB619307:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8638fd-45cc-40e8-70e0-08df4579d8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|4143699003|56012099006|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vCDEUOoEkFpvjceyGWDAu8La2UYjdo/8fNhl/DwRYJ7RdZrO4wNV5PNXQAsCgHC4b97m/LVTyk2fAaiUuxs/GRzMdfyIFWnNcpGc2vQ5KdE9+4hnlriSfr47eIc3j4tOVnI9y9cdwfd3L5qNnPBYsDggLzEAnxkG9lGR/ydHhEwaXcN8bdNuyfCzQcsqmwXIW1mLC6+NtmBZrHyvFM4ibfhk72DXDZUWlWR4+DpfKCClowfI8lbF3rLyCQMQr+RUIBnIT8vDGcAFDR3O68eKu2GV8Vzd1Ji9iv6LzEeK/dGLgDJcLF2666+CIV/Vf9C66Y3+5SAjEdMiDMEHQ3zE1S4jtqXBpdeH75jcYiAIy+UwpHTYTiOKt8tLMPb/fnRE0sT5P36/yjF1cPJ1Y8gR/jWR85Oo/MpkSHrKzlL4+WQTvcjdaRWv3p/e+c+ve6drnezvRewKj9cbvihlkKOt9duNHRLTt7QlDQ/5jxgebpbQaZvJh7YBZxuwptwvYyIZWeznjKU05T0n9JvHxMQUnf6n5Fx37vS0VLmRFMONoz1+hwsEcOoOBjLVRdDFMY4AtqR1iSO05Ktx0ELWQSWPZfDPade9ekV0ObJQScK4OqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0pWRW9wdEk3a0FZeUtoY2FpY0J3SGZRdk40dFlZejBISUl1SEJmOXRtVG9V?=
 =?utf-8?B?dHJlSW44cG1XK2JOM0htQXl6cDFGRU03NTBaM3M1QWFGMVZuWjM4TTV0aDJj?=
 =?utf-8?B?Y0lVYmtFTmRGM09UWEpMMjRLb21KR1BIMTJLVW9kOFMyd05QVmxwUENhVklr?=
 =?utf-8?B?aENXOW9hVW1jVTh3VHdqTWZpL09NcEZ1N2hYYzQ4Z1Z1MUtsZWRINHMxYWVl?=
 =?utf-8?B?TzA3R2JiRitYczRScHBoVmVrdGF4ZGVPZWFSSkhZL1I3amt4YjlnSEw1VDZj?=
 =?utf-8?B?TXYyY2VaMlJSODIzVTlGS3ZvWGV3aUk5MWR1T21KMlJLbGVINHg4Ym5EMzcv?=
 =?utf-8?B?MTVzL1dJbmZIZCttNkVVQkVqd3MvczU0RG1TVzVhU2hXZnh6NGNoZGVQb2pC?=
 =?utf-8?B?a2RLbjhVT25LM3V1MCtPSncvK2N3cFZiemZyQUQrWHhGSGNKUVRUdjN3cERB?=
 =?utf-8?B?Rng5MTIycVJKcFlRNzRiekJBMURuUTRDUFY1MkFBWG1tRFFudlZBVmw2eTgr?=
 =?utf-8?B?OHVqL0JHbTVWVmprUm5XWlk0b29qOXY5aFhLNnJOeGNidUxUZXY5TXJSakNz?=
 =?utf-8?B?WHZOQnQ4MUQvbmJNSTduanlSWEhWN0JoTzhkbTdTRHd4SHlpQXd3anc1SnE2?=
 =?utf-8?B?ZWpQeVUwUnlPUGt0NVg2KzJ2b3ZIRUh1N1VTVXEzU1F1OHJXRUtkUFoyUFFG?=
 =?utf-8?B?VktHOCtRWUx4TE9VUElqZXNSMkJ4MkdIbHFSRHBVT1BOelNBeUdyVXRiNGly?=
 =?utf-8?B?NWdoYTZ6UC9ncUxjOTZhU2xWc1lpcHplSTlpSFYwYUg1cVVveWR4ME9SaFNX?=
 =?utf-8?B?YnpCQ2hYcXg2eXpvcEo2Y0xCYTBxOHNLZ05jY0R3S3hQMU1oVmlEZFEvWUNC?=
 =?utf-8?B?c2h0a0puT1djVmp3LzEzZjdHUlpQaVFheEZTVDVsWWpWQUs5RXpIZTkvREpy?=
 =?utf-8?B?VEp1T1U1OUgwaExrdzZpNW9yY1BiT3lVQlZkZU9UUGx2OXh4SDBSb2dqcFNJ?=
 =?utf-8?B?K1I3ZUk3RDU1MkFvY2xEL29KUk80N1N3eXVkTk84YzVXTm43QmNUczVCSW9a?=
 =?utf-8?B?OWprOFRzSlRGVVpqaG1ieENKZ21SMlJicEdWR1dwaHhMTDdUMVhCQ1ZxMWNG?=
 =?utf-8?B?V21TNk5UeFJNTFViTG5sZGFCd24wME5ueXVJZmN6ZDd2cTlFZmFscVlKRVI3?=
 =?utf-8?B?a1NaRzFmejNCTjlUZTBvWUpQSlpIZjdYRzZ6WUxzbDZHMWEyME5NR3NnZG9P?=
 =?utf-8?B?eTZ3MExiUHFyZXNPZVc2bGY4KzBtbWVZenlsQzBpRmhJK2lzemplS0lSS3hS?=
 =?utf-8?B?cGZiQkdORUlFYnFORXp0TGI0NkhtL2Y4Y28rejZzMHNlWDduWnZrN1NsaEZv?=
 =?utf-8?B?Ym00MGZKeHJsaE8rZnE4VEZReFBmN1NhQmVZSUJTT3NsMXdyM1lucUp0Ykw4?=
 =?utf-8?B?VXNyY2RqSjdMUjVYOGVPZkVRYmVWZjE5aXZYMmhMYjZmOHB3Y1l1WmFQZmpJ?=
 =?utf-8?B?K3FDRVc4RmpZd2xsZXAzNFpvYjNXcEozTE1LN0NEdUZubU5GVlg2WWNvWTBl?=
 =?utf-8?B?dTdIOFVvM01UL2picjE5NEMyNlNzeDNHL1lTd0NIV0IxY0wxeUEvWHNicGRu?=
 =?utf-8?B?VkVqV0xxZWk4Q0JOaUxvWldqVWhKd3RpRmRpTWQ1RFBWS1BDcXhFeWtXVjZM?=
 =?utf-8?B?ZENsQkQzSzF6QXluOEh4ZjlXeWd6U3VUMlRoVUVCZXpOR3QvMzlGTkpwRnYy?=
 =?utf-8?B?ZnVyQXgwTnJUS09XbXIwNjRwVWhSWXE4VGwzSjVNRERXYjFYU1dSWk9YelIv?=
 =?utf-8?B?VTRucC9tcE5Wb042OEpyM01YQmJBajVvcU1aWGJqcnhQZmtSVXRnNWZlKzJ6?=
 =?utf-8?B?ancrQVlncW1jSHEwRmh1Z2lJaU1wYldCNXF3MDdRZUUrQ3U5aEhNUFZqWnI2?=
 =?utf-8?B?WlJ4TUJYWVZoZGN3V2poVUNVRTFhVHJuN2dyOTlrZ3haWnd6TndLZFowQ3BR?=
 =?utf-8?B?Z2hIVS90WHVmck5mcHJyYWg0Tmg2U0lMb2tUU1k0ZUJUKzlaMW0wUXluL1Er?=
 =?utf-8?B?d0lKV2NCTFg4UkxZZzdNUDZDRkFVVXJGdW9PZEVIanMvQ09YZFdhTU4xTDRZ?=
 =?utf-8?B?dkE1UTJrRXduS2p0dWUrN0t2K2p4aDFEZ29waUpKcUw4Vm5vK1UyQjgwRFVM?=
 =?utf-8?B?djRKOThpSmZwUFdScTJnTWlkb1VkaFlYaGt3dFo2MWhaa0l1ci9wa0JIMzI3?=
 =?utf-8?B?NmV4N2ErWlhTTXdaSys2bFBnSmJSSm9lckpKclNVcFVLdGVWUWtiMVBZSjJn?=
 =?utf-8?B?Um5zc0dlT01MSGMyMzdBeTU5TXBZYlo1ZEZ0MHhKZzU4UVZtbkplZVM2TGRa?=
 =?utf-8?Q?3fkKCiUp4wNgZ13UW0chwZnfBxGcAfyqGj5Ep?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8638fd-45cc-40e8-70e0-08df4579d8c6
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:42:54.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55THFR9NgOa9DwJvZNYdieLyWOI48CQxegFyJnfy151eePEXrkUcQaW9WCR+jVgTvm1jkm+7qkzHhPuTwt2WH7KBQwJjNEY+cCoKt/okj7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB619307

> Can a boosted SCHED_DEADLINE task with !dl_se->dl_donor_refill keep
> running on its old reservation's remaining runtime after
> sched_setattr() shrinks its parameters?

Yes, but its own runtime does not limit it while it is boosted. A
boosted task is never throttled. When its runtime runs out,
update_curr_dl_se() enqueues it with ENQUEUE_REPLENISH, and
replenish_dl_entity() refills it from the donor. A smaller runtime would
only bring the donor refill sooner. The CPU time during the boost is the
same. This is the inheritance design of 2d3d891d3344.

At the deboost, the runtime left is checked against the new parameters.
An implicit task keeps it only if it fits the new bandwidth until the
deadline. Patch 34 caps a constrained task at the new dl_runtime. That
is what a wakeup gives.

You are right that the comment is loose. Without a refill, the task runs
on its own runtime first. The next version says "A boosted task is
refilled from its donor."

> When a boosted task with dl_new_params set and !dl_se->dl_donor_refill
> is deboosted in rt_mutex_setprio(), does deferring update_dl_entity()
> until enqueue_dl_entity() miss the post-deboost re-boost check?

Yes, thanks. Patch 11 resets the donor refill in dl_deboost() for this
exact reason: the re-boost test and the chain walk read the deadline
before the enqueue. This patch left the check of the new parameters to
the enqueue. So the test read a deadline the check could still move. And
a blocked task was not checked before the chain walk.

The next version does the check in dl_deboost(), after dl_drop_boost(),
when the mark is set. The re-boost test then sees the result. A
throttled task is left to its replenishment, as at the enqueue.

A new test case, deboost_new_params_reboost, shows it. An owner shrinks
its parameters while boosted, and its donor times out. A deadline waiter
with an earlier deadline remains. On v7 the owner is not boosted again
and is throttled: its 20ms of work took 400ms in each of 40 runs. With
the next version it took about 20ms in each of 40 runs.

> Can calling update_dl_entity() on dl_new_params mix the previous
> period's dynamic state with the newly written static parameters when
> switching between constrained and implicit deadlines?

The first case gives the wakeup rule. A sleeping task changed the same
way, and woken at the same time, gets the same new period upstream.

It also gives no more than without this patch. Without it, the task
keeps its old runtime and deadline. dl_next_period() reads the new
parameters. So the timer refills the task with the new runtime at its
old deadline. The task then gets a little more than with this patch.

The excess is the run of the old reservation before the change.
sched_dl_overflow() gives that bandwidth back at once. Its XXX comment
says the old bandwidth should stay until the 0-lag time. The message of
this patch names that gap. It is not changed here.

In the second case, dl_check_constrained_dl() runs on every enqueue
upstream, including the one of sched_setattr(). This patch does not move
it. The task is throttled the same way on v7.4-rc2.

Both cases were checked by reading.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
