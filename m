Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203865;
	b=CQ3IW7wF5j1hnh1ikye/vMpI0E7UsDPJXbf5m3gfqTq9OHfsMiPNpzgzwSL8+AekBBal
	 WjdOfDJyumLqbTwuDu4kfmnuwe91qMDuqcXv0ED8Uw/EadChWlZ7c++OH296aCkFhg4f4
	 978jOSLQRwbo1sYyOPsXpA32jsmLSVPYwLB1LP3WsC4N0tRje2KpQLjbZk3Oe/ZwrJnjI
	 dOTDN9DKQPuHKUdmQmI08howIr7iywHuN/BWhGxc1nIGgXicW9+Xq7O1duVX6yFLzzZH3
	 cKf74zp5iK2TiXdRUp+vvDjHxvZ8PQ/Xak6mTwt0mMXPT5RsB9SFqmtfpcdoZ/IzE0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203865;
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
	bh=9n2XrsUoSiqF0c+cslmSyODLO8Q/2OHTLRPtCnEvy9I=;
	b=deNPp7betOt5VMMRUBu7ZJn8j2+sojdHCRD/o+qnZn7qr5tLjHSXlZ6TvIsAOIZTpEgp
	 NqvNu5FWGJjjC+ciUtTQGC15mj2+kDETJAQBqVsXteWl/GlGiIp4Pr7u0qBu23l6bTKOy
	 X+w8K4P4BpvW7OoOFtZqJoduNpSwgEZH7zzg5aT9mrp8vn+upCLHtpbwZ1Eod2VSnVnjA
	 uKCYYbUIOanG1/J29H/vEfS8YaIuKY2TrQZ3RX523V8xINhyvE6VUK5VC6+073NEVTXt+
	 AMit9Itqb922esj0dgp6FxuDSlpMHHYJhuT8enTxSRIDDxYE3pLn0gNEiWmmyMCH7Vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=YOp6yjyo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.81
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022081.outbound.protection.outlook.com [40.107.193.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F3606A6EF;
	Fri, 20 Nov 2026 19:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C26F3606A6EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=YOp6yjyo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY73F8FursPvBHerHmD8Cj0vFgsJhVqqorT1tFPczysZOCyTqmWXqMAQ2sfkRZqjuvy1rTNF6nAwlQH9U5RzJb3UK3Dx0Er7nPL17wWz3pWeZmWskVyPoRaiw0BUzjCfWw6SwdU2aVRU5quabtBLdBAQ6FTlLasiQIv5qusB6meitsYq+KhnMFrksCkwdrKYEtouk+bRHcdJ/BngH8TX39j/hb/rgFvEGFn1E+X8QM4wglqP8b7IP9erP3qTDkqtkSJ5cbUcygKnOYMYW/q3yzuHrvYj0x/hPgGE2KiD6fDXgfml2+k7AIFMJ5LIs2RXO+tWUlhGLAqYjaDeKagADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n2XrsUoSiqF0c+cslmSyODLO8Q/2OHTLRPtCnEvy9I=;
 b=nLvFZL12EmurVIhq0YZVmRvor37iyphQ0y6X7FOCJRxYkTW6ycM4+inXeyB7jfQial2Icxw0iru/s91jN64Jb/c3m9MGPW44QlOxPGreckBl8e1pn2prL1HDQyErvD5yH1mau5/f9b2W1gOD06zAwJQw0dOUyYAN5yhERcAcXJMZ9ym7K3Q7/VeYDHHbDjrdegLiwrlniNJXgTxDDjQQApPBxmK6UWBCBiTwRTRpQwLxkEnEQc6f59BnY+XwHZp+e1agGgCnsuzF/gkZMWBa1BfdGiGCDVzTQbU1D5j1BFGZZarH4qarqxOydAIIc2nzt7lreTZNWSMrAiv1t4z5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n2XrsUoSiqF0c+cslmSyODLO8Q/2OHTLRPtCnEvy9I=;
 b=YOp6yjyo/KPXJNyNYluYvuqmc4kvLwpXJMxDVEa33gyQINZv2cbwj6B0h5IW96Bfy8rcDvWYZoX4ed454X2dXOYQhf3AUzBJZsSEnsYXful5ghejx6L3k3ftTa8T/fNULQpq/zef9YQDJ530GUWavYWkFP0aWSgyEyn3TvBkTIYFZwN4Ymrdlz43Z4cWrjEZkxRFhtRK+t5K95s5/jTMUpVZrWcXUbV9EVhvG5iMIXYytbDeWwoBh+rugg1ub5UNX8YlWq8/VZCRkvV5CCN57HUm8pkhKvFjb98anXmAlyNi8zs1sFYv0SyWRRyAEFeQn6bwDn8E4Mb0c1W6q54nJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB6254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:44:22 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:44:20 +0000
Message-ID: <cfb5b270-8b9a-455c-85c0-d421c2ea102e@efficios.com>
Date: Fri, 20 Nov 2026 14:44:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 32/33] sched/deadline: Check the runtime of a task
 whose parameters change
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <d65436da41c304678dd3d77f003f32d05583fed7.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225415@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-225415@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::24) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f27ef47-0568-4ad1-51e7-08df473eabc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|4143699003|56012099006|261022075727099003|261009223027099003|261021121427099003|261022105027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6Tg43f+EkV5pGoN+OriEu4afGq2JotJkgQGh3qQiczvuOZPeaL5fuMBQVdicQ0Il4rHxhcF1FRY/tKxD2IZkMo2SZYT3O2H0vr1Z5ITalLy0aICkcL/WqUiOfh6W7cZQVbm3R9Ro9tFVGRfB7gnX55mEMUO+uyyIWvqfNHmEVVyqFsk9ryFn2vJhc2z8+ugT5zen0aAnt6NiLazI+wE+BVMGyR+IWdEdoentDBCG0vTKH5zFzDHxWuu25kQ8gCW0WilXtBwsTx953BRu8RK7sUXZe+qRXvg9HixLEz900TMh2yrVdkatZMFMFsjKqju2M2+h02NRXxVSLnUH09Xg/il1zqLSxUOloyjrqi6nWHqvplSCM+dR9kHfuOGgf5Y4KU8P1OT9Kp9yOtnV+JSVu+UWYqbiJcjhGIqP9DpZOVd6C3MC2Qxs8CDRWKyYjb20wJFPwCOowkLmpW28gaFMX3X81Denw3L2gGENrIE87yJ/NQ/h7ZvU2XDh9DFjfyd0FKaZWKuxA7hok5PD6Dt303DBsfgfmPi0y25XdPYsGmJKx0IR9RVsbVy/TfXzJ/5qIWMP9HzVZvnHJqq+4Ao2bf9MQX0uGgzhS5eSvvs826A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(261022075727099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCtOYXdhbHBLb2lvUFhtWCtVaHNYbG11SFpNV2ZiUklVdzNDWEtDYWZUSlZP?=
 =?utf-8?B?MUlhdFB4ZEpOa2svTTBrSHZia1lhQjlzVmF1VFlCeHVXb0xGTXdIbUdUTkZs?=
 =?utf-8?B?OEF6bHpDMjg2amJXay9WT01RczRvOURyeE9PckVRcGl4Z0R3Z1cyc2RjYVRn?=
 =?utf-8?B?K2g5YXZ6ZCt6clpjSjVvYzZlNmhrK29tTEZaYzlsL2hiMTNKNVEwWUpyMXJj?=
 =?utf-8?B?Y01CZGFSTnBsN3VkMVRta1pGaytSMldWb1p1S3R1YWJRR0RiY3RtenRFbWpq?=
 =?utf-8?B?Q3plbUpQZWxsMC8rUXFwTWc0MUJucFkwbzUxUldKSnlOcWxQUDN4YVJrVnJB?=
 =?utf-8?B?dGtlZjNZQVhNOHdqSlJaLzF4NUhjZW5uaEJNYnZFak9memUweVNlQzNvMW1O?=
 =?utf-8?B?UERia01XQVlFMjdYZzlRSEg0aEdWR2E0UWdqbDIxY1BrSHFDby85bFhuZlUv?=
 =?utf-8?B?d3FSdmFVUnoxYmN5eWJmMExVZFlRZDVVYlRwZFoyZjEvbjFDcXVteXNJZTFB?=
 =?utf-8?B?cHZLSFhKaWt4c0pWUGFGVHQxa1pMWk5XUk5nZm81NG1FaExVZ3E3Y0FIMXF4?=
 =?utf-8?B?NmNacnNTb3B5Wm1KMFBCcHNpdTloUy9QSW1nek9JM2djOVlveTZkZmFQK0h3?=
 =?utf-8?B?TFpQWXp4WnRqSWVabVpJWG9iOGZkbE80aFNITHl6alEwRFpVMmg1MkxzaWFX?=
 =?utf-8?B?UlZqUmJDdFhVbVM2bFJ5aERPK0xBMDVnR2tyelR6NXVoeTc2OG9pa1JPTTA2?=
 =?utf-8?B?NU5TT3R0MzVDUk9Va0p2RkRUdGhvZml1ZHVUcFNtWnVNdjNIQVNLVEFJcWxz?=
 =?utf-8?B?TmJlb2xQOGg3Vmk5RGRnZ21WK3ZKWFVSK0RubWlLa0VPd3VTS25kNm8vNlQ5?=
 =?utf-8?B?MWtXajJGOHJxdm5rK2orODRZRWllZEJtRnpIVFc5a0VOWVI0OXJMWVNSbW9G?=
 =?utf-8?B?OVRPNjExUEMwbHhYVm1NaFdRaGIwckd6L0J5OGZoR043dEZROUZhbjlSSm96?=
 =?utf-8?B?Kyt6K1RuTEloU0ZWQ1pjM052TUVJL0JjREpqOEJpcUlpdnpIcS9UN2hVeWNI?=
 =?utf-8?B?Vlh2cEdrTDlYZ3YyTGo2MlpOeDZQbkZ6cFV5SjRBeXZidkVLemNJSnR2QlRN?=
 =?utf-8?B?UUs3L1pLVFU5Yk9jaWsvRXNuZVVKamhjdnpNNVdwdWRaczFPSEJWSmJFS2Jj?=
 =?utf-8?B?bTVsUmllUDI4WlkxTTNVSjlvcWRrZDFMditPMCtvaDlTdnpkSkcvaEZuaElY?=
 =?utf-8?B?RmhoMFhMTS9CUVRMR1B6aXlKWlJoc1hoUmdyOE9GdGVDdk94a0VYQXFiU0c2?=
 =?utf-8?B?a0ZqUk14d2gwMTY3YW1VdlJacHZhOXlNN2gyb0xLbWZjdUU2M1RvcVFpc0ZC?=
 =?utf-8?B?VHVDWEdNbTBCOXN2SVJzU1A2b1dBckNkWFlNR2hTZS9HNHpnbFM0MFFoaWRB?=
 =?utf-8?B?a2xuSmFXR0VITkNuNHZ1WjJhaysvMWtpemxYSVl6QkNvOEZLcHhZc0oxSG5y?=
 =?utf-8?B?Ui9GTzhsekVYMkZNZUFWSG5HSFR2dnZkaTloUEJsa0huMXVhSEpIQXZWOEFq?=
 =?utf-8?B?em1TOStncHVZMHZWZnB0aVcyQzNraC9qR29NdVNpTHUzWGRCL1RBN1dhVlpN?=
 =?utf-8?B?QU1BRG9jc3dxei9CN0IySnJCdnVmTkI3OWZ2RmNoa1dRb2g5TWdmVEhsL3hh?=
 =?utf-8?B?NnFMb3pnaVVEemxlSzhrdnd4OHRyOWJQUmJFVzgzKzdDejFSM0pEa0ZSWTdv?=
 =?utf-8?B?VXBsYlROdTBXdDJZMUpGOS9IL2FRc1FoTTVmaDN2OGVMSk14Z3JRMEJETDJ5?=
 =?utf-8?B?eFE5cityeXhwZzFUUWdIcDQ3Tkk3NXJ5UjBKdGN2WWhLa2F2cmx2a2dzcFBM?=
 =?utf-8?B?Sy9JcFRUS2h2RlFOZjhqU3NMMnI3MXBKL0NVMmNkMjdHUUVPMG1tZWUxdmNt?=
 =?utf-8?B?Vkl4K3NVNENoR29QT3piZXV0YjVOT0UxTUpjY09LUGRKa0d6eituT1c0Qy9L?=
 =?utf-8?B?bUpndDVycElvbEMyN0Z5eXQyRmplZG9UUzdCZTJ5dVlhSHI5SGFvbGY0ZElz?=
 =?utf-8?B?dDhaeTNWWkY0Y01sZ2NIaXBwMmo1TVZqR2pIS1B6QzRaekRMUC9BL1o2cDZH?=
 =?utf-8?B?TjJhZXRTaFdNUkhJZENlclpJUmVZZlNvYVVuOTJIeWdtTjAzZHpPV0VkSmRt?=
 =?utf-8?B?cGVPTEFSTFVRdGhvMlVUcVFKWGRvQ3VCeTRaZ04wS092NitZaWxmWDhpMm10?=
 =?utf-8?B?UUFTemxjYXNEME1jRTQydU9VTlI0TzA0NlFrWC9oVXZLNzZFZ08vVEZFOFVK?=
 =?utf-8?B?UmpRUFgzWkRwbk43MTNrYUtybzJIMktCTUNnWXVJVG4yVm9lZmN4ZXl0c1FX?=
 =?utf-8?Q?lJkkqsCcQbsaSIeOqOCk1NveLEscdxILaNE9Y?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f27ef47-0568-4ad1-51e7-08df473eabc5
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:44:20.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji6V7b8xnTJpVyRUoAq9TqlO9W3T78O5P9bzbtnvUAUVSSWcSadSkh/8xNYT/MEpLvTjq33EG6R7jbRGToTHkybI4w7m6oi9UT2na/GPyck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6254

[ Sorry, I replied with the wrong content in the previous email for that
  topics. ]

> Does dl_in_constrained_gap() (as well as dl_check_constrained_dl() and
> update_dl_entity()) mix the old dl_se->deadline with the newly overwritten
> dl_se->dl_deadline and dl_se->dl_period?

Your first case is not a bug. The task is implicit after the change.
update_dl_entity() then applies the wakeup rule of an implicit task. A
new period moves the deadline too, as at any wakeup.

Your second case: yes. It is older than this series: v7.4-rc2 also
finds the start of the period from deadline - dl_deadline. v10 will
keep the start of the period in a new field, period_start. The new
patch is "sched/deadline: Keep the start of the period across a change
of dl_deadline". A new case, wake_after_deadline_shrunk, will test it. It
fails without the fix.

> Can rt_mutex_setprio() skip dl_deboost() by comparing pi_task->dl.deadline
> against p->dl.deadline before dl_deboost() updates p->dl.deadline?

Yes, by reading. In v10, rt_mutex_setprio() will deboost a task with
new parameters first. dl_deboost() then checks them, and the waiter is
compared with the deadline that comes out. A new case,
boost_new_params_stale, will test it. It fails without the fix.

> When dl_deboost() returns early on dl_in_constrained_gap(dl_se) for a
> running task (or when sched_setattr() puts a running task into a
> constrained gap), who calls resched_curr(rq) after enqueue_dl_entity()
> throttles it?

Nobody. It is older than this series. On v7.4-rc2, any change of a
running constrained task in its gap gets there. sched_setattr(), an
affinity change and a cgroup move all do. v10 will fix it in a new patch,
"sched/deadline: Reschedule a running task throttled at its enqueue".
dl_check_constrained_dl() will call resched_curr() for the running
task. A new case, constrained_gap_change_running, will test it. It
fails without the fix.

> Does returning early on dl_in_constrained_gap(dl_se) in dl_deboost() (and
> prio_changed_dl()), or calling update_dl_entity(dl_se) unconditionally
> afterward, break PI boosting and sleeping tasks?

First: yes. v7.4-rc2 also compares the waiter with the expired deadline
of the owner. v10 will compare the waiter with the deadline that the
owner would run on. A new patch will do that: "sched/deadline: Boost an
owner that cannot run on its own reservation". An owner that is
throttled, or in its constrained gap, cannot run on its own reservation.
So any deadline waiter boosts it. New cases, pi_owner_asleep_in_gap and
pi_owner_throttled, will test it. Both fail without the fix.

Second: yes. v7.4-rc2 sorts such a waiter the same way. It is your
second finding on patch 26. v10 will list it as a known limit.

Third: yes. In v10, dl_deboost() will check the new parameters only for
a task that is queued or blocked on an rt_mutex. A task asleep on
anything else keeps the check for its wakeup. A new case,
deboost_asleep_new_params, will test it. It fails without the fix.

> When update_dl_entity() here (or in prio_changed_dl()) starts a new period
> for an unboosted rt_mutex owner and pushes p->dl.deadline past its top
> waiter's deadline, does anything PI-boost p with that waiter?

No. This is how a boost works, here and on v7.4-rc2. A boost never
gives the owner the deadline of its waiter. It stops the throttle, and
the refills use the donor's parameters. So EDF can rank an owner after
its waiter after any new period, not only after a change of parameters.
v10 will not change this.

> Should switched_to_dl() also handle p->dl.dl_new_params for a task blocked
> on an rt_mutex?

Yes, by reading. v10 will check the new parameters of a blocked task in
sched_setattr() itself, in a new helper, dl_check_blocked_params(). It
also runs when the task comes back to the class, and clears the mark.
rt_mutex_adjust_pi() then requeues the waiter. A new case,
setattr_blocked_reenter, will test it. It fails without the fix.

> Can consuming p->dl.dl_new_params in prio_changed_dl() desynchronize
> p->dl.deadline from the task's rt_mutex waiter node when prio_changed_dl()
> is reached from callers other than __sched_setscheduler()?

Yes, by reading. The same helper fixes it. v10 will remove the check
from prio_changed_dl(). A mark left for later is then consumed only at
the wakeup enqueue or at the deboost. No case will test it. It needs a
boost or a gap to end while the task stays blocked, then a move.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
