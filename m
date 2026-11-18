Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009287;
	b=UjmRESEsIbQ8qI24lP8gw4DkTb69KZMAnB9YO3rxBH78FE2XZq+3FN4rGYxRVzifCDkc
	 Dsj4XJw2nS3eDCtZPoPraumS/oApxk41K7sA75ABmVRGnwtGzqXNp+qxLQyzg91sNT6Yn
	 ZCpk1s2jz0IwTC1BX7dA6fkJ4FhLLlmKv7D59tG5sKxmJ2ZXS+AvwpFGSuzLmmcNEGuQM
	 sAXGFjNUSa8/+O348vn8VR71C0h+okHNdUOEw5MRNK1i0uVZ+NbN7Ydo71dIoW3U53xUv
	 nsJMNUGj2Kf3/SBPjQqOK171utlqPkVzSmG0sr1k3LfzEC0kwOMhuUJWJkuYlPeNFHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009287;
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
	bh=MQm0gCDOzUVP1nW2fCT3k6g/NoASg9+vwfkgBcwAxn8=;
	b=MGUBQhRxUYLLFb73jLpiFEL2QklpugQMB1EVfRLVl/vemTRizAZXGg3PqBpXBxBFO87h
	 vsoi84X4O0mqMt9bC6JHgO4Oki/1DGLX8m9Kt0fp7mdSSTf4O6cuf04Rfm9bMwXCgrGcl
	 7aZifvABj4UqbcfVxqfzktGklzH/GtzfBUYks/vj3T9sn9PYPGtxAxWNdEvsKePDT7e6f
	 imtQ5P6iYNERq7r2evfzeNzsnijaaiIfrLiwsqX2xwT/qJSxXwnI5CiCS62u7kKuQW4HF
	 YLJavhfwLf9ADV3Sd7KCudCeLCcxzClzB6zFvKwiJLbDJSEpnQNjSalAGqnZZXk3bWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=cFlkbT0S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.119
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022119.outbound.protection.outlook.com [40.107.193.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952B606A325;
	Wed, 18 Nov 2026 13:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8952B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=cFlkbT0S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZITUnoacq+hJ/Y/CzevgKlJEyb8UyGCskA848YwTDdq59SJ573h/c+xgteGryvf4eEyc+JFmRt4FtC8xyd3lOojunLtDf+g392QoaZLDupLNd44ef2S6vIQPyZIgnUPiXJpDJvMO+uygh802ntXFpFsgc5tL+Ird1VHx+nEoAe8PCxVOY8hIsl9SWNxPPcM1N5zJeiisHZQeN9dXVHYJVV4JwFOz26xYdE9cp+j/MyuMNEygCDwviCT3UU0LkVkmVcxnCp15gDJI/aIEgPGxyIEeALr70RCn97/Serb7PmhZdgizrCiGgy+DUoymtqGNmCSz+NurSh2QyCR9G2N+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQm0gCDOzUVP1nW2fCT3k6g/NoASg9+vwfkgBcwAxn8=;
 b=eq/CJOnNwdys/VyuNCbp5U7dMBdH9BRPnfrva/i5DElBFEVICdUnQdT416+tPYHMv7z+mCJduzkSuoRH3T6AIckA9jZmI1DHWzf1dvAvK5wSQ1zQvekB2a1wpCSm2/hfjFrUC/I4tsKPExQILwi8x4+vSe8u10DizKAgFyVQ3mYxiGp/VfqNnSd+Rra5TtQhd6C4iMSs5nWPFkwLMATItTgT1iuzT6p2Mb/YwtJjrxr1x1a1Wi3C8TQnhFx0hDXbneo6oQbSe4+9lBiHvIyqspemtlsKEPcmF0KZUswK/6pRBoxiEyILOy+/1hoUOKIbmtbSE+BFxsqoEPvR3oY7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQm0gCDOzUVP1nW2fCT3k6g/NoASg9+vwfkgBcwAxn8=;
 b=cFlkbT0S6QobxUYV09Xi0U8Q4Zuhl9mroJx4DWbE62cMaQnOUekZAmHf8pKmaLkfgopfZJLW0GPUU/dAgZgNbV12KqZLnLk+VMO7jAScWjYH52Trp9J6vpmztYWkhrnAEPnhkhwl4eXSUdUa7MdWySKno9ldT9xIfAQ9vAgp7dWk4uDtPhByf6v1+ix8KmR5xGxydBDhCSevUBuNpqXO/Hxzpww8ATjVZNsrEItayaTAiPEpPFiRYalnUZAWIYb+IjH/upj1rj6l0SWpvFXYivigeYVGVdl1ZwYVBFdUn0R4gQy98wF6nLKXbweQJQAePNaTVNlOueTBdGbBLAIaSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by QB1PPFA2F60E653.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c08::274) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:41:24 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:41:24 +0000
Message-ID: <5949872f-320b-44c5-bf2d-829cd4523d36@efficios.com>
Date: Wed, 18 Nov 2026 08:41:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 29/40] sched/deadline: Keep the last CPU a task has in
 its root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <a075dad17300a5b31dc3d99bef81fb9dadd6cbcd.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219096@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-219096@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|QB1PPFA2F60E653:EE_
X-MS-Office365-Filtering-Correlation-Id: f5eab082-454a-4bb2-e2b4-08df4579a394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261026140227099003|4143699003|56012099006|261026121527099003|261021121427099003|261022105027099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HN6gch9xKvWJa0vGWjTIGhL+sCrA6jkWfek4SzFEcG8wh66MMHbAJ1QvSF4cYrq2ukbeYlTxw3Dfo1aUePVDZJINu3DJQ/M0J4KR0191t6D+Cy2mrPb2lLB2WU1zm8XcVfso+re1+Yq1jVUT3QHgIlXkML+vottZrLkUe9p5APcmN82XkUgtb+VPhJfhWc31srBGmXvxUjJZfGpjL9GqTwX1/yqvenDn/FT0wgkCP0kGtFKNK/1WhNgdm5s1hy7x3dRjWjnBMWphgbab+egE4tPfIc67b3+R2TSvAAHEk7ViS0FGUerXGt2/InurHM5af+3FlPYPYOd91CLiMtAIGMKFDnTwJhWLg49WB9wAhgqNeGKGw75tx7DuhtPWpnNKFtVkGHSbeogdrMg4AP9ySjBhtLbpiRGWD+CL2m1EHM3aAxIcbup3n1uY7TyxlntSJN6Z5+EtsESiUFoaND7tvvOzf2rd8FGDh8jE3lfBBdaner4R9+zGzkthgO+MYYgUC9e4fehkq5c0nW85Ep4HazKrW49qPtZFnQrCv5zBZRrUlqmkiAhlRCWgSqC8S7BWVJAmqvadJNHPC8mA9ACDXpPnTzHUJFb7zDQMa3x/H+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261026140227099003)(4143699003)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkNSOGlYYkR2enFkU1hzQkFmQVlaaUlxUjBtTjhGQjdZclVIYVAyWGM4ZXQ5?=
 =?utf-8?B?T3E3bHZTQ25kbDRNVXlWRzN1YkdqZFZVVDdTVEk1akRYRjBBemZaaCtXQ0t4?=
 =?utf-8?B?THUzalR4Mjd3aWZ5WFM0MlQ5Wk5VZEhBcHlxYjBLaGQyS05WZVE2MEo4WWRH?=
 =?utf-8?B?L1hJMzZIczg1OVU4NGY4UTdBcTNEYkY5MnB2bDBxTDJzRWUrVCtxVVVkanZw?=
 =?utf-8?B?UldGU3FMbGFxOTN4TW8zYVk3UlVNMGhQSEYwVlU4UHNEUXJtQzlmY1l4em9M?=
 =?utf-8?B?VmhIMFVSSnUzZERBb0VWYzZWaklRY3pOQTUydU8wRm00R2hXU1d1bGppS2xP?=
 =?utf-8?B?akM5MHVPVE9yelFuWTU5L3Zyd09vZG04aHJIVmV2NU5Xc3VmaE1FdWo3ejJJ?=
 =?utf-8?B?Q2dMUkxFM00zODBDRWN2QkxMOUhWUUUzdWZLRE00OFZNMW9ULzhjTlJhY0pq?=
 =?utf-8?B?T290Y0l1N0dRMUppbnl5ME4zSS9CYW8rZDdUalJrTVVXVXBHQS9PWTdYYlNK?=
 =?utf-8?B?TjZUUmd4WTVteDZZU0RyR2orK2hBVCtEaFhvcFAxV05uUjFRSFlkeHltbDRw?=
 =?utf-8?B?clprV3FCbVZsOFhzL3d3QVZLdGp1b2drMTJXampTOFNPRnk4SEU1M2VmK045?=
 =?utf-8?B?ZUdlK0ZtcjFENi9RSW0rMlh5VmxsVzJtTGNvY3o2c21VOWkxeVFaM1NLU1ly?=
 =?utf-8?B?V1U1YkI5MkFaTTlLNUNqMFVIUUxuR1dHbXM2djZrNitNaXNKSmdFbTVhT3pG?=
 =?utf-8?B?ZVR2SHYxb1o0TXFPVENIYndpOEJJamphbXBqOE90Vm5BYzRMOU5rMkVOa0h2?=
 =?utf-8?B?VGJYTjNjREJYTXBUczVVYWRvNmJRLzFoR3MwaDdDd3BSSUhJc2d1cVNwK0k3?=
 =?utf-8?B?M29mQTBmd05FTDVNNUYzYjVTTWFrQSt5dFYvOW1LRHkvSnR5Zi81enRyaGc0?=
 =?utf-8?B?ZEJ3TCtoS2srZGhoWlhwTFgrTVNWeXByYmwyV080MjIreFI1K0hrbVorYTZF?=
 =?utf-8?B?RGFYS0x1UVJjaGcrbEsrSmcxV2JGRWFQRkZNTFJTNll3UHR5RjR0a2FjOW9Q?=
 =?utf-8?B?Z0k0S2M2RzN6MHpoeFY3cDhpS3gyYmgyNEY1UWd3V3hUOGRhM1RRd3M4aEI5?=
 =?utf-8?B?MDBBYjdiMWpYeFZ1ZTdWcjMrSnZoa0RjTDZvWnZjZHhFRThrdkpONy9LWlda?=
 =?utf-8?B?dmhxUzBJMURtRENhQzFwZ09JQ3Z0MEpHTzZ4Q3ROdWpibzZZQUlxNkNRNVVV?=
 =?utf-8?B?ekpzZ1JRL0dIZG42a0NVQlkxRFFlMXVXWlZHbEtrZ2xVdk1Lb21vbnNBQnR3?=
 =?utf-8?B?cEQ1S2psM2RTTTROVitHaEVHS2ppdlJxTEJWd1NFbDFZamh5U29YSDJQS1JT?=
 =?utf-8?B?MWpNUm9pdnUvR0RyN3Z2cHRMeFJGSHhKYk92NlFFMVdBNTVjYU9WT0QrSE81?=
 =?utf-8?B?NEFpRmZzby8rOEw1SCs4clpNazJ3UUM4eGpNYis5YzNmbVNPLzFxdlVTVmlL?=
 =?utf-8?B?NXFSNVVwaFdsZzN6VjNEaUQ5R1RFNzcyK3BGc05zSi80SHZMMlVMZTRER3Y5?=
 =?utf-8?B?ZjdsWUdxWDV2ci9rRGtPZkhqL0NlSHcvYWp1Z1JFdjdzL0tjZWxicHg0NlNB?=
 =?utf-8?B?dWF1bXU3QkJBSFNuTXVtOXVQMUYyQ1ZiaFU1SjAzYVZzSzhmai81bjZMNjQz?=
 =?utf-8?B?WGg5bGUwNElXK2VybDE0ZSs0ZlJtSUNXSGdUcUVRNytubE9DcmN5SngrNlJy?=
 =?utf-8?B?OUFKSm1NUmxneW1FRUp0UUFsVzZyS1hWQ0pJUkZXeUF1eXRQR1V5dHdxMVg0?=
 =?utf-8?B?WEFoZmpRWkRhWThQbmhobUltS0xWT0xaSWFnSE1xU3AxSnNrUFpSSGloc0RD?=
 =?utf-8?B?VzkwSmhQV0YzYVVsQ3cwUzhDUXdnSkNRY21HTkN1TlBPNmRnNTFjSGxCWjlS?=
 =?utf-8?B?QURueDVzM09vUUVMU1NpZHEyd253YUV2L3p6ZkVodThuZk1TVXNtcStmRFZ1?=
 =?utf-8?B?WXZ3aW5mV2pFekx4Ui9SMVVvQzFQM2E2ZlpId0Y3VGE4SkRuQ1lRMm1rdVdi?=
 =?utf-8?B?WmJSN2R0dWdzQzdyTlNzY3AzV3k3ekFlS3ExU2dFRWdQT2N1bEhqRnRRWTFK?=
 =?utf-8?B?WHNNYkNybzc1SzNqYW5lbC82OVE3S1JqZDk1NkgxR2QyeHVXNWZwY1BxbnUy?=
 =?utf-8?B?ekRWWDU3OWk5cng2cFZvc3MvdWpISmg0NmRVN1F6dTlqbXJzbEdTa0VpZG9I?=
 =?utf-8?B?TmsxS2E5RUFNN0tRUGZrNkVwVS9WdVF1TUdwSktIK09GSGdTS0EyWXl1M0VM?=
 =?utf-8?B?RTZQSnpWcHFNQlJIMlF4c0d0NkQ4NUJlVHNScVZJemNkZlpJVm56RmF0Unlu?=
 =?utf-8?Q?ZuB3oX6M+VHKLyg/bdLm9bvIjNkYRI5XgnaUx?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5eab082-454a-4bb2-e2b4-08df4579a394
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:41:24.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XVxqbl2U6FmAkwVzBLRrQLXPXjrQY5G5PGloVI/xUFMm6ndF73qDRXVVaRYsADIZCVFSNCmRew9k/TcQYebVRss/dXSDihAJRYA4rHnpOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFA2F60E653

> Does cpuset_cpus_allowed_without() return an overly wide mask when it
> walks past an intermediate ancestor to find remaining active CPUs?

Yes, thanks. cgroup v2 computes the CPUs from the top down. The walk up
skipped a parent that then inherits wider CPUs. The next version starts
from the nearest valid partition root, or the top cpuset, that keeps an
active CPU. It then works down to the cpuset of the task with
effective_cpus_below(), as compute_effective_cpumask() does. Patch 30
already used that helper for cpuset writes. It moves into this patch.
cgroup v1 keeps the walk up.

This was found by reading. A new test case, hotplug_nested_refused,
tests it. On v7 the offline is accepted, and the task wakes up on an
isolated CPU. With the next version it fails with EBUSY. That held in
each of 6 runs on both.

> Can intersecting pmask with task_cpu_possible_mask(tsk) after the
> ancestor loop leave pmask empty when an ancestor has possible CPUs
> for tsk?

Yes. The possible mask must come before the empty test. The path is
select_fallback_rq(), though. The cpuset update fails on an empty mask
and leaves the mask alone. The wakeup then tries cpuset.cpus, then
task_cpu_fallback_mask(). Patch 28 makes each step prefer a CPU of the
span. So the bandwidth leaves only if none of those CPUs is in the span.

The next version stops the walk at a cpuset with a CPU the task can run
on. If none is left, select_fallback_rq() picks the CPU, with the change
described below. The check now predicts that change too. This was
checked by reading. I have no asymmetric arm64 system to test
on.

A second read of this patch found a related gap. At an offline,
select_fallback_rq() runs before the cpuset update. A runnable deadline
task on the outgoing CPU is pushed away then. The fallback uses
cpuset.cpus, then the housekeeping CPUs. These are not the CPUs that
this patch predicts. So a running task could leave its root domain while
the offline was accepted.

A new test case, hotplug_fallback_running, shows it. A deadline task
with a 2ms period runs on the outgoing CPU. On v7, the task left its
root domain in every run (8 runs). The next version changes
select_fallback_rq() in patch 28. When it would widen the mask out of
the root domain of the task, the task gets the CPUs of that root domain
instead. The cpuset update that follows sets the real mask. With that
change, the case passed in each run where it was not skipped.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
