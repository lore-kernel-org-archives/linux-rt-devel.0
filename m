Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203428;
	b=iRs2l8twyvTaxzZrhTv6hLLH9dGpdLmGzM1NmIDF2SSOmVPRYkmaXypSDvPsXR5BPzAf
	 7CwTyklUsa/ZXQTjp+n0i29VbYu2TrqnrfyL7mhEaZm9v/XWjQY+EvjULdGCMVMXOCPOS
	 eXwMNRJ0XG3Ze8L+5N1fTSDzGtYLU7xysRxxB6Iy/9/JhAPo1yQ+E1Mj/W5YbYp88kOTN
	 nxKHsDEGApOKqZfZ2aq3JXnEprmrktRqTpdB29lSQAZ0rVhlyacojpDv89Hn6gpUnK2ji
	 MosnWsnmEu10qma1W1gXzO5AROrOCjZESezDlD3XoQOIHZywA22nvhQSqfMi3pTSNeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203428;
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
	bh=Imk3m+h/04qQf423UMXGT8xM9wBNbXHh7Z3XppduO30=;
	b=oCmt/wpeTZMhAgtwHxZ5i13x/YqqB0vAMUVJfVnjEUNYPawAdrCafRFNMSWql1ek1INi
	 ub9BTldTDj96AyR7KjWAiM4wRfTB7o+qKC5O0CeLgPJF+AhgCejBf02B59mbfHD3H4437
	 eo5kVBP5rKnuobNj1Su0P/oi/66bpQ8xDerCHrqIAUCrnZKancf+Sx+cAEaQdxt3FMeFo
	 5DoDf0JisvGOwwZuhN13LGP7drgSFjSMQ9uM6AxpNabGqPVVt2OoM2fBHHAY7Al25Smrq
	 2AkMzmwZkZISXAOx2E3zG+XHumOCm0URFb4QUYpPdP6S4jzw4q+tBOXHCkvyWIPnpYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Ae9DeDQy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.88
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022088.outbound.protection.outlook.com [40.107.193.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BC606A339;
	Fri, 20 Nov 2026 19:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D9BC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Ae9DeDQy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbNObz1XG70/Eg9g7E4qzByjtjCjitKsfu4TsGVSnD+VMS6q8rKoU/Cq8T1geZPQE+I9Te/6fNTEjv+U8sdoecTLPzc5w1kWb+MMjwmmE/ffJ9gXUOGiWuvHeZNeMi70312XQS9MnaYutNt5CocYUSrMp5aYyx3TL2J5YBDZZ19KjPoQaeu760DmkFAXugn39vg/7Tee9AS2OjfIAljM+XRlhbmsNDOHo4r3flyDbs6qtwFVbnnVMMIwYdbh3r2L0p+hLrH3+nl2svgQ5EFFg/yjB/rqU0stpHgKhvtmqviOwRUIWSJIsUpcekLOAP9JdKBrAiiY52pdQMV5hi4HSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Imk3m+h/04qQf423UMXGT8xM9wBNbXHh7Z3XppduO30=;
 b=kcVsMu3qALOmFLir69FUQuk3OlOJRc01LpkpR2dbU+HTF7KJZoCdNC6DCzP7oelVcUVbAO6XObpAgNo1oLVyS6053OJiQCCfDovJxU+Nhm+DElLBDsEgHbamaXsmKCkHUxVTLzS14LFsbCyJxlz/i+zbgjsNQaNGkmMppW6zKkqcXXBTrx/ibiAgNbnzS8bATYt2Ab3SaoAQTYNvnfRDALaiC7OMYvIBQCLryWOE5LZw6vHloWUjzJlPRBaSkjn6YHcwt6qeIRos6jImXfMV4UVijeJtp+7542Eg57PH99iZ5sIc5CVg5n9uV8II866nW35YRoFPJEXMc8AHwsICDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Imk3m+h/04qQf423UMXGT8xM9wBNbXHh7Z3XppduO30=;
 b=Ae9DeDQydDnrTrx31LLy9TDj5EYaplFkp5ZExXIYWE3DHNX97wC4p4e3amjtfPxnWY32e2sMVQV5jdeVuIVREItPW6FkEc/jX1DKME78rpD/WNm8Rn++wB3vuaMyNm0dD9xedXRpI4ng+pgxHlpmYJFFFOnNzcr1MLzqDwFacXXDE3pj8jIPRQUTg81Tysvn4k16wu54CnUym5GH2Oomxt1yZozHAce3PaOasFpNLifs/orZRYDjkGSmrcTWhMtvfLSntmQ1lBJHazvBjtNENDFO3UZYhd+yjsCLEteUFGgf0z5U9Vye9XOW9//eRJ/pbaWVUBS+w6bOIqn2MHjK0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB5667.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:37:06 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:37:06 +0000
Message-ID: <af9a42a0-b8e5-453b-ae0c-a6b56037490a@efficios.com>
Date: Fri, 20 Nov 2026 14:37:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/33] sched/deadline: Keep the last CPU a task has in
 its root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <05ebb23f175aca8ebb3b93eeb2621f07a0a352a5.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225376@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-225376@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::7) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: ddea879d-ee62-4287-9655-08df473da905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|22082099003|261022105027099003|4143699003|261028144727099003|261021123027099003|261026121527099003|56012099006|10067099003|261009223027099003|261021121427099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	pXmza/ozE8X3F88pJy//2XnrEKWleIrppyrQeAhU9AOcQSOlo6mWOB+xDBuEg6F0VDRV0PTxZR+JxkrskQqzs5LhPX46XKIHd59z61ovCICXt3EQ51ukpmCepUFuqCK2ozbUJcmAFJRinntYf8dgE5qcvd5M6eXdcHkwIEcd+Dd5pqj8iZZhTDUwT+9rg0FvB3wgFiK+YnsvBiYIpFG4xdMLTbTJSHdnmCJmoU1wqZR3dqmBQmf+cwDRTwyjXjGCiqY2+gMxicMe7a7Tpb0KjEN14bjC7ZDYyfb4ZyaPUooNn2lN0B6aZLS9Bf0XvuLo0Od9F7UFEy6cOgRoi97cQ4f9AQpJgk83c7rUoqwq98XlSfkafLw77S7vn9i1m/mKSSCCjEDpi9NXs9dlKyPspFl6LFUai/Uk3AFrizpR/kMnsyGiZSsdZ8qq2l98wUM1k4ps/ZFVYTbIT3E36tSFWSBXQUGta9WIAwzfUchdpudlo29C/9vd4P28aZABQu2hNCkvfEvxXcKkLI9xwb9U2nIZ1ue5IJ+jKoHlilk5DUIA8XVrgbyaFJqcXdlRc1MpKbnPLDn7ZkS5Syyhxat9J91LxJYyh1l5hG2++33uL8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(261022105027099003)(4143699003)(261028144727099003)(261021123027099003)(261026121527099003)(56012099006)(10067099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjZ0dnVZOGNQenpnUmk5UWJiNHVEZ3NwU0FCRFFiUW1RN1dNeGF0K1h5MUZu?=
 =?utf-8?B?ZWs0LzUySDhNbE80MHdJZWJNT2FTUDk1aWRoYTcwbm94SUc5R1ZieWlZV2pu?=
 =?utf-8?B?Z0xpbGl5N2hoNjNRVkdPK1c4MVd6R0xOSUp1TzdUZGJVWE1EdHVjQ2tkaUlP?=
 =?utf-8?B?NVA3SlA4NFkvY2tHdWM5bEpPWkRROGxyNTI3eXVzRXZPVjk0eStLR00yQlZL?=
 =?utf-8?B?NzY2SC9saHF3K1BVWTd3QjJEMnhhWkhBZEtzdjJXMmZibXRTR24rNHU0V2pH?=
 =?utf-8?B?UUhYdSsyd3JqSDFobEsyVHA3NjlicmdXUmRWNVdyM2U5K3RsbHp3am5pZWpC?=
 =?utf-8?B?R2tKQU5xUldjaEJIbWE1bWVFamJNSXc3R0x3M1c1dkZOWmpCMFJaa0hPTFlq?=
 =?utf-8?B?ZktLS1RLb3pvdFhKUjdMa0lLOXAzT094N1hRdnBnUldjSEx5Y3MwRVdpNzhU?=
 =?utf-8?B?dGY4NG5KcG1EbnZUWGZYOEJic3ZDYkhWVnd6Y0pXaVdQQlIraHpVWTI2K1lV?=
 =?utf-8?B?eFB6dFJMUnNhd0dvQ3k4Z2s1VmdiN0YwMmh6dUVZYVZlSUVJM2NHOElyMDFo?=
 =?utf-8?B?Um00ekFOMTZSSmNURWdKVUY4UzBaTHg3ZUJGVXZENVVIV1RaSnpRU2FPVVpL?=
 =?utf-8?B?RGlUaE9Ham1NdjNTVmIvaUhGZ1Q0K3BnTXlrMERkcXpHSmVMN2ZLeHFVb25M?=
 =?utf-8?B?d2ZBUHFwbVVvRTBaTmt0QkdtZFdGTUVoMjV5Q0ZGYmFOeGFseDFoQnkxNjhw?=
 =?utf-8?B?L0NadjFkcFZVZTVKTXpTSDRwZ3NaZzRuYzFuNUc3bmxZZDNQVXZhQk5xYUFZ?=
 =?utf-8?B?T25mM1hXM0lzVklDTXErcmVCUTlEbXVqbXpVeEZjbTc0dEEzdk1MYnB6MjVB?=
 =?utf-8?B?ZWhkK0htblJuZmVNUDJ1QzI1azlqY2tJemZMZE81ZTgxN3Fta3dlV0VtK0Rj?=
 =?utf-8?B?OFFtU0pyVVg3SUZNYlVUVUVvZGxzVUkweHZnK0ZYOTF1cW16UnQ0QmJPOHNo?=
 =?utf-8?B?aEFDNmowWmkwOHJ2MHptbVBUaEdHVUpxb3RCbkhKaXFBZlVHMkJkZUxyWVFD?=
 =?utf-8?B?Q0g3dzFKdlpjdjNwdEl6bFJ2L2JSanBISXhERkxaR2lUVE8yeHZxVUtQbmls?=
 =?utf-8?B?Slp1WkdCTGRUYVBqSm80eWRHZ05PSjg2TFd3NGlETnJxNi83RDBDVmo0dHpZ?=
 =?utf-8?B?RzcxcjBqTDZqTjJkeUpKWFRzVmUwV0IrQU9oWStFQ2dEc3dVNVRhUGtHclBq?=
 =?utf-8?B?VlBiN1RUS2lDeENsVVZPZmhkMG9uak9wL3cxUFhxU0xyOFo1MEtBVG1sTHRB?=
 =?utf-8?B?dmRTdmhueXhSbDEybXNVUE5GS01WZXJsbnZQcUhhdXp6QTFvVXFLeklNVXBl?=
 =?utf-8?B?WU5tNmtoT1JUekQzZnQxMmtmVVRPTEhkUnVEbUlKbXdTL2o4U1YxM2R2Z3Ri?=
 =?utf-8?B?aStEaGRWVmY3Q0FKK2pKb2F3a0N1eU5vNksxZzIrZFJwWlZ6U3VnL0hMQ0JV?=
 =?utf-8?B?M29IN3d0MFBtdkZETXpEaU9XTU5LcVZPd0czSXllME9ZN0Q4VFlKbDZoTUFi?=
 =?utf-8?B?aitXK3JTRC9uVWhDNGx3Y3Zpa2E2V09sNE56Wi9nc25aWTZrb1ArdUVvQVhG?=
 =?utf-8?B?ZE9oRU9CWG1SeU9mMzBsM0hlaVJpS1FKM1JZcmRWN2U2YVFhQmtkRlBsbkdv?=
 =?utf-8?B?YllmK3F4V09KWFBNUXlHcHo0bUF1QWx0UEcwZStsSnJzb2xwTGpPODM0VDlu?=
 =?utf-8?B?bnFOckxDUkhZWDQvZDFLU3hGdTBBT3VVVHZFYmlDS2d6NUtyTkRHb2h2cEcz?=
 =?utf-8?B?biszeFNxdENtL1AxeC8wTjRQVVhmOGgyLzd2eEdsWXRsY05XQ3UvRTJkdmFu?=
 =?utf-8?B?TlFuaW1rTTQzdmwvczdGbUhHZEh1YytQQnd3SlBoNmlJVnlUZFQzS2VPUjZS?=
 =?utf-8?B?U1RXSktRRStTVGhmWE5CREFXckZFcVZpUG5VcnhFWEZoQ0lyTGx0RzhYaCts?=
 =?utf-8?B?b3dRT1RXcTV2aGRnajhiUUZlWGRWSS9TZUh3VlZnL0lLeVppdkpuQ0k5T2U0?=
 =?utf-8?B?aGw3QjE2K29kelBrbGMrRVVuQkpRcEpjN1ZZVlZ6aFB4bEF4ellPa2dXNEZR?=
 =?utf-8?B?ZWJ5MGlQR0pxcHF1MHlQVGNKTFo5Z0VXQnFkdit0Y0NaTHFxaGM4ZVR1QW1N?=
 =?utf-8?B?SUxWRUwwUDRNMDIxdEJqNjlUSTNIakRRQWRqSHZGWjJSeW5PS2VRd3R0ZS9P?=
 =?utf-8?B?dE80UjRScitUdFZEKzFXb0lMbGVrUXR5dkNnNUQwazhrMzlKTlJkSkp0QUdH?=
 =?utf-8?B?OU11ZnNucE1zYkJ6cVpGdmxuV2p6UXNjVkRTN3J1VW9tMk5UaHZFMnBCc212?=
 =?utf-8?Q?Lx56eyQNo+yMITpecbAebmea35SaAYfNrQog4?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddea879d-ee62-4287-9655-08df473da905
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:37:06.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvw9T0tcokSFqbHYsYuETQ9OAUBwEZHZ9Nov58+x0hsr1f3XDALk+ZZI6G1la4D9SJFd9xvs1iNIG/6AiH0fZK60eD29po056ZSfv5gZPE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5667

> Can cpuset_offline_moves_dl() and cpuset_cpus_allowed_without() miss the
> invalidation of a sibling partition when an unpopulated parent partition
> delegates all of its active CPUs to child partitions?

Yes, by reading, for the tasks of c2. They change root domain with no
check for room when c2 and parent_p differ: one isolated, the other
not. The tasks of c1 are already checked. If c1 is not isolated, its
root domain loses its last CPU, and the offline is refused. If c1 is
isolated, the check of each task sees them leave the default root
domain. 

v10 will model the cascade in both functions. partition_child_lost()
will take the child partition that cpuset makes invalid. That child
then counts as populated and holds no CPU. So the parent loses the
sibling partitions that cpuset makes invalid after it.

A new case, hotplug_sibling_partition_refused, will test your example.
The offline must fail with EBUSY. Without the fix, it is accepted.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
