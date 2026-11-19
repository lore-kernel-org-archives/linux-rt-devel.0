Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795104462;
	b=3qi65aiDYEXH0Z23q0wCo8REAOenUWni10koWJyYcBnpqxFapQ/0GLR0rNQ2gr1FiP7F
	 GmNaz001j6WOWd64tNUp8lnNovcyG/uWPN7RQilkmeNYCUtsWy3I4mKWlUxb6IgU7XIvV
	 A5yT8TG2xAexnoshLRIph0Jxa0c0korUY2mcEgDyjurYPm+Uepfdf0JPtgKrJkISkFQPf
	 J28C62xLcjLFAdulPHmPv0P1ffXnVrzARiUsOLTNNIMJR+zN7feGyuqy/ex1vEtgeBDBL
	 1AtMxfPy5dmzmqjFYW2fO7kESTSl3Dt8bBuHVP7uKuVypu35AZKWcQba8R7hq5wQa0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104462;
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
	bh=HgNpceFVuXXIp4Ox28hWMRO/wq8Vnl89mX/YZZfQqiM=;
	b=HJ0dcPicMDKn83hO3+FicaVp4IBiARL024axNiWvZfkrPIJ2dgp3Smq3elIAJG8pI7ax
	 65oxUOIssf1IG2FhtylwzVqkvCl56irC6plFq/3IGU3RyKFv0EaJX3Pgd/aGhgcAtGDYh
	 W/yE6KR3vZzV/KPl9Mm2ejSN9+TCZ6A0Jt3nnY2lrUZpXK6KUAjZoSzjFCj7HHVSStKe/
	 /Lj+sqdXG0x7oKxHQ8FTrbq0kDGy0M4SOnlIiQrXm3MkKylt3lgDG5+iV5YU6AP33PyuE
	 4Hyow6Lt0dtxAPQTn0n13QaFvtDwk+HcKSMkEMZHB405B4fJmvNTgn6GV9pJdHkNYkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=mhT1LBA4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.97
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020097.outbound.protection.outlook.com [52.101.189.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A21606A320;
	Thu, 19 Nov 2026 16:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A21606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=mhT1LBA4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpCoqG7nLDnaD3bn1EIf37GGmMbJhI14nz08Xxxk5Dn1fxY+mk+wP3pXo0Ol8FznFlgCmXKUcvuSAb+gL/u4t9mumMyBApu7fHxcu1EWSBAuz9nX8r728pE+xpYrPcmA5yMVxmkOaXQReiVa8CwxqO67+Ew0YrdqPdyenUhuWCKWdGpRZsZxhpgJWXKGEbrmkPbAvLPShVuHxUvX9X054vDEhh7M65FHrWdFrF5HZ52hMvmIf25CaqAkY4Dei0ALXkLVAj3Qap69RbvCa9dfNsEzOZ0OmNMwdcRK63CBtx4DLKuzZU25fOwZgbiL7jiHtZsfxGmROzTVYTYyk0O/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgNpceFVuXXIp4Ox28hWMRO/wq8Vnl89mX/YZZfQqiM=;
 b=n35r2DsQQeLPYVZDIR4QxjEfkv/te/SShdquHDyJGSU9gdwD9CoObY0ri071W4mhzD1wUwVzO/0Iy8m5eXKufkgD4U5ZRgtfveo1OCaIdZSaGK5u3Ch5XDPLch+J4aM181Cd0pRW+wyaVtT2hbwnur9FBKLIoejoTWz9hXMCi1ZLbEb1jxliciBD0HR1ZDmw5kujhp5PMOD7RJ5oPxf1U2hRYsUVTSfzFQy3V22IrY4T2k+N/eVuYtuwvmUpbmW1nZAEU8W7OViWcd5GeLFdik2AbnzaJsVyAQMRyhFLGV++iERGJiwYCpFG0Nueqf2hE+8Fl7LUNFkfxFhK7wcugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgNpceFVuXXIp4Ox28hWMRO/wq8Vnl89mX/YZZfQqiM=;
 b=mhT1LBA4TcD/Ifja3yz7CPXhzZQiqopk5NF+9kbZ9ZJE4+M2u731yj0gxoUnwzo9ozqO2COAVuZ5rsdkZ46lHr7GnN9p0eSoZiaCjytFbeQQmmNjp21L3IuNvW4OCtIy3nienqSUQw/y8T/a/GZJasjohRzhlV8DdbwbPUGBtu21NOYfWxMXgXyP6nM979K/XVU9HgDFYBzi6ikgsXpPiiDsneJg7T8Jmfzlc2Msm36vxE56ts7FDPC3k0GIilgpQdwUFtU4M4UdwKHQBs0XwxdzoOK7HVlnQ9twy349cqi8iHXVSDw64NlGIa+p8FUMEWMHFFnzkqPQ5kqFS+LMOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:bc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 16:07:40 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 16:07:40 +0000
Message-ID: <39fc5cad-6990-4945-8342-d66f66ddc692@efficios.com>
Date: Thu, 19 Nov 2026 11:07:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
 <cbb59b2e6ec73b9c32cd43ef6ddc8548070a5942.1795092090.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-223287@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-223287@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::28) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2234ea-c055-46c9-5c25-08df46573cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	mWqVQqEtp+2Rf0T7asLcQuylWp+NJM+k6LJLzqNvZeYJbpC7cDD1rqGuzrWqP8lvMY3zVUN7QBLbRqIU4l7CAR0lu9I0aOq0AFOOL/eSbPQqS13hrYDfjFfO1irJdqfdA/An8NRNQcZlxblygQhJjdlXsdGXNIiQp0Sm5xkObrt3Lr1jc7alB98V+G6cijHMEXfytwS8BcsV2FgFWqdo+6FVknhM6P505vPwvqkzJdFJnhA8C816zHw4hJKpGIbXWqRDkVKkTobtzQHpZcElu4GDXwN0y3N71KtuOrmyeJibOcWfaY8fWYUGeVEC66xVcyp9GNQJC8PR20XRjw0BY6EeBRRv+/UozUHWNQVbR+xtg7WGroUL+7Qk/XhWNwGt+yvGEnMgs78p9AeQpEZmpPdVFyDSeZvOmcNfGTAdQm9WIvP7qgDwRlER+L4JBoahEU6u3ul/MEdWdWtQVn61+0MdFKqBBIk5MMD+zepeL99JGJlvatM9jGOMrSDMcbi0+IjsDD3Apc4BmiXI39IyIf5dSB6aH94EZw9ZPR6U8fReZ0dKmCggUj1NWkOS18kq+e2tmT0+AdGdiu4lItfxHAIhCf8Yb4f1qQvLAYGXW8M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(261102123227099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3d4bTREY0FKSWNkVEFpNStJK0RZT24zaS9laUVUbGJ5aDVaeXB2TmZhNVlM?=
 =?utf-8?B?RXZLdmFPait3Sitmb0tBSzZUOFBwcHl0WEROZ3VZTFdRU1B3ZHNRdUNvNktP?=
 =?utf-8?B?bDNmSWxVRTAybXhHclVxUlE3Z01WcmpEUDhGNXBWQ2lNOUoyOFFtdFZHNlRS?=
 =?utf-8?B?V1VsNzhTYmw4b0VCOWNzc1FJOVFPQUdyTVNvODNSRTNhdHRpSkxhR01VS0w3?=
 =?utf-8?B?Qmk3c3VLcmY2STFCUS8velh3dzBWYlRqeTFsT3hoeWxTR2FLUm1rOWtpQkNJ?=
 =?utf-8?B?L0RYQm1uOVJDR2J5ZUF6V3R5V0NhL0N4cHUwcGpBamlkOHM4L04rd1orZUE4?=
 =?utf-8?B?MjlYMEpyalAxc2dNNTFLeFJBTEREd1N1eCtTRHRPTnVmVjIwNzNha204MGM2?=
 =?utf-8?B?WlpNYlZuNlF5cG1mbXRNenRuK2ZLZzZxWkVsNW9LdzBTTGpRVWNGY0cvN1d2?=
 =?utf-8?B?Rks4UmQ0NVB1bVBPc1NHYkpqMkhBQkFVSE5CMVFvV09FdDJiejUzSjRlb0R5?=
 =?utf-8?B?c1Y4UWtpZXo4Q3c2MkJxSnJ6THkzZnpGTXAwcUpDUUhKbmRzTjlmR0VGczRC?=
 =?utf-8?B?Z3Nncmo1TzgramQrb1FDaERxMDNwcmdaWXVadFNZM091M1pBdWI0aFlVTHNF?=
 =?utf-8?B?TzVJOVpGVUVXeHdaR25QR0JuWGFOMTBPMUZGU1h1b2NPNkRhZjJSK3QwYnE3?=
 =?utf-8?B?R3JKZ1NLSFgzMUg4eEJhQlBIWXF5TFhHeHVQcEpma1hjSFlMKzhSZjRubUpB?=
 =?utf-8?B?UFMvdVpvdWJ6enBBNk9MdDh0OW5td2lwYS9zRlhmVE1aMnlCN3U4OTZDbHlo?=
 =?utf-8?B?UjZybFcydXM4aVlEcEUzK0ZtVWZwbVd1U0g0TUJFYTlYYWNoRnJmYjluclFX?=
 =?utf-8?B?TmJmRE9RK052djIyNVNtUnhnekswVVJLVk5aT1d5OWp3QWZNY2E4dnFtWDVs?=
 =?utf-8?B?UEM5UUxHbVpGcndXNUhQWWVTTXgwaW9OWkdSdnh5MEluekhRN0tWTmlDVUFY?=
 =?utf-8?B?K0dEZVM3S2E2dmhWZW1jZGQ1SzErQktFcnVTSnY5Nk4rOWEyVUR5WU5WY0Rj?=
 =?utf-8?B?YTlIeXZWQmtSK25WaVJ5SkcvRDZxOHJFSWVKS3M4SzI0Z0JZU2NNeGVIVTR4?=
 =?utf-8?B?bWVUS2N3ektxZDlBcmQxUm5YWmdoOWlxMkUzVXUzZ0FIckxZMFEvQnBMaHRR?=
 =?utf-8?B?YnQrNFZuQkp0SXZ1UzZQb1BDVzBycTlidmVoWkQwVktCT05DTS9ud2U5cTA4?=
 =?utf-8?B?bTFDOFFnSWxPQk1UVjNqSzVoeDBaYkpkbWdHN1VyVUh4TytTUEVjNGE1eTJS?=
 =?utf-8?B?K2pTZWVNOHIxRmlGVFNENW1yVnliKzErYTZUYUhuRk5UK0VlR2g4VGpZK2Vx?=
 =?utf-8?B?ei8wcWN2WUlDZ3pjTG1BNFVOeGloRElMZzFzUXM1d2xUYTltb1hId2ZJOHY1?=
 =?utf-8?B?M0dhaFdUa1puYks4QStUSEZ5cDZVeXcxcmYwMXpBL3NMTjRwTUZSa25aTnpT?=
 =?utf-8?B?NDRrY09JcEd4ZmYzRlZxYlhWeGtwS3VQbUltSWtpdWRhdTh4MjNlazdacWYx?=
 =?utf-8?B?dEZqd2xaRHBvb1d3M3B3WExta2pNZHBHY0RiTUFpNnE3RWxFZVRMN21HdWJ1?=
 =?utf-8?B?MkhQTmlNOUJpeFdVcEZOSmRYcUhmRHJZTEs3dnJQM2hhVXhRTXAzR0I5WFpy?=
 =?utf-8?B?VmtvWkhSdCtNbWxwL2REZ0hvTEx6ZHg1dDBsRy9iSkhQSkM4VlRONWNoaWFO?=
 =?utf-8?B?aHY5SDI0YnNKWE1DYi9VM1VRUENzbnI5N1VhUFFzT3RXSzJpTWdXTWhubnBE?=
 =?utf-8?B?TDlQUk42NzNtYzJrWTZGSXdTUXNabEJHbEhKME9yKzR1b29KWEtNbVlYRFZH?=
 =?utf-8?B?MGV6NkVvUUpMNjhpSkIvaHBIVjloYTNJYnZEaFRObmNOOWhQNkVTQXZEVGZx?=
 =?utf-8?B?bGUvV0dkTTZoYjNrWUMxVk83eWZ2WkdhdGxvNVRLcFIzMEV6ZElCRkNBU0dZ?=
 =?utf-8?B?YUpiNktWK1pXUUUrUnBHRmFCS2U0UHJUTGxCaERld0ZYK2dQU1FDcWNyRGJ0?=
 =?utf-8?B?d05nS1NJMXF6R0ZpbGhBTklJMDFINWw5RnZQMEhZeFFLa1lwUEV5Zk1MUDhx?=
 =?utf-8?B?U1FqYThFOStuOEZpMGlpd0N2Z3RMM0pCbmx1YzlZaXNwcTZlSmluc3R0REVI?=
 =?utf-8?B?VVVPcDZaMjI4ZHdRdzhyTHBKVHJrZmpPN1R0d1hVclBvdGZsVEF3a0c4MjRM?=
 =?utf-8?B?ZUNSNFUwdDk4ZDRnRm9pL2trMVZtcU9IU0VUbFM0dXZyMmJwblVGdkVDbzU0?=
 =?utf-8?B?QW5GalFWZEUrUEVsWFVsSG5xR01nY3d5UUZaV2hZRlNTWUlaa0NtT3Mrek1I?=
 =?utf-8?Q?3K5yOv97dD+pB1AM1vtoTmwxprYJe4XcnPcif?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2234ea-c055-46c9-5c25-08df46573cd8
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:07:40.7814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1XxcwysH4gxNgRa338lOvVZKMzi3tqS81CjRlZa7s6APmZVGOoNCz7uob3LjlXSFCdM4O0M6f6eBD7+RrkP8POKmhO7zvEyzd6oWPPMe48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9061

> Were these extra modes meant to be wired into p_cases[], or should the
> unused code be dropped?

Neither: only cases of the second series use them. They were left from
the split. v4 will drop them. In the second series, each will come back
with the cases that use it.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
