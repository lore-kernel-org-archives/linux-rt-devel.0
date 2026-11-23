Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442206;
	b=lbi6McEGG2ladQCMj4Gqn8XYLkfuzu8ccjr9U/xuUkIm9XVtG5hE6kBk0wpjqiqHSSD4
	 Tx9p3sdPgg//VSFhN9g+FjUK0SZ1JUKfXK9WsCrrfzLtk4O4kJ8JNKGxOcmd2oGX6q03B
	 o0E5UPwUjhGcJU3NsiOTzse9YkekjP3u4Y+1gEy7r25NfwF5rWgWzFV+bhYJ/BZ4OVQdN
	 6gqIUsix1wNVubZ9FRfnIpxePr/28kfQgeOZDZBH+e2cJrqlb05O5HEtjCROEvHX4oAGj
	 GHAfDJZFjaDScgenivEx/h8eIRx4x7/rNDzmY2UeIq92FLb/2qFROJoC5Sq8p8Bmx4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442206;
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
	bh=f+P71RNRXkO/XJ60Knn9OfDKwgA4tBC3l1UBBqmqROY=;
	b=zGsyQWidR6ThqiaT3IWvB4QmQjNx3b4gRwT0in/eYna6gIq3TzHDNVIgJniyXM30WmXj
	 uKjYuLr/kK9PXswn78TVrgR10161T8LVq6LuQy+ETWhrexmAqwOYIm0CJxHm7NmMHOwzj
	 a9rwI0lYboi+CQwTOHW4Hom/HSTt91O1RmAYw0caKCvhFlrtJ3+5dgbXmAAlhWv0aVe+T
	 zbrZrNqysTrT+cChbXtjCbqwr4zJ/5qETUt+7H0XaeIjJuMysXMt8SYDI6+UrGbL8cma6
	 k000ulGybAvWK6+miw4AYD/KSyobvIDi4RspW7vR11axM41dsIqnYWYc0EP+qzNbAZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Kj8kIDiu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.92
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020092.outbound.protection.outlook.com [52.101.189.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC7606A685;
	Mon, 23 Nov 2026 13:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96CC7606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Kj8kIDiu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6/XCxAH/3B4z8z03XISuB1DWCzKiGkCYSoYIa8kVHzT1nwscICnNQKrV9Lxrp0UsbVxmg9vGcegsyuZAepQqnmGp89+nGX9DvKqtvHzMmuX9HMDm7KeK31vaO13rgLNBulpyvD6k7mbVEMFDCwm7xzOf3hylQ2FRslBNPJU3B8OiBImMO5mZPgYTrmzzzkP2j/aKCXBv+UQBCENrxXRyu0C9Hh5kwHYW0GxcoUAikhcRrhfjz6w4+M9QPFfhnfxZX2XlaPdX0pttwqZfcMqUcq9vFuepNZCaLx8JXMMERkremtHoiF1fTpM1pKnC+VkZG2tpI3IpDy2JQ4SJOreYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+P71RNRXkO/XJ60Knn9OfDKwgA4tBC3l1UBBqmqROY=;
 b=vww4XpCy5kTksNoCYmbBYMrbJvNrT1cXFbjHRxHbkw9N2K0FaqlkaGpwxXW6OFvb6m4rN79V6P+hblUZqfgBHJV3AywmFVy3UunRayDwWcTpmYg4f7ir3y/Ftssbv4yAbDWypRuvRiIDlQiHJHIV8ZXB///m0Dld5Kot2Z/vWKMv2jGhVNs9wDEgTSJfkxJUkMebhBziX8bCSMTZb/K2nzJ/P+GwMV7jYd2APVoBktDyMmecgZ2ldq+/Qw8PIfRmhBzP4Flp883tTz4N4TLmB5KR5DlfURzJOenwpyKWLNIZ/N9mMPagOaiq+FxRRUvLMfPwBJEb+v2KLoqxtNrmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+P71RNRXkO/XJ60Knn9OfDKwgA4tBC3l1UBBqmqROY=;
 b=Kj8kIDiuIAb/8pdarvI21QDOMk9PubXiN1DSURnC1G9Ctm18hNabzgGBQATu7Rp+xf/Ej2B0xIQbgKmmvTR8RmR4k4xEDYLw9G1yZ5mYyco4Q6R2X2S8fnDX1utfLSYDZrTGjB4NIXSfF85vqWgRFYre9rwCt4bDNjdATyq6hP0IJBWRe0UIOuhfJLt3MPRHW3JpN1ss6oU/YXwSiEkdQyJAyB1+BFteDSZyksZ7IbZ/DLsul173W53Nb878L2TN68+3ww/uWN8uwc1yJjsLaYizBn/Zk9rXovQ0jRO1QmTq6CJSKoRjYGbdTVu4Slhm8ZPLN7MjeeoXkmiw2yGhOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQXPR01MB5199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:56:40 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:56:39 +0000
Message-ID: <08e953d4-9960-4855-a1fb-1a6127b993e5@efficios.com>
Date: Mon, 23 Nov 2026 08:56:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/40] sched/deadline: Record the root domain holding
 a task's bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <1d10d1a2f94b18ec7e51c1c57833a34c2481c092.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226154@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226154@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::33) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQXPR01MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6d1ba9-8cf4-4564-d705-08df496998fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	v9C+PfNcbPLytStdiMM2cJqfzS7kq9lC4cvCRbyF7v/avaE3ENhiIwgWgkTwTzBfUoOFb/ah8Ij8EeaGmzF2dsFWYv7+ZNdwu7FtUzyRHIptuyLHQV0BrOV6FPXr0aQCczi9Tsf7hdNSxiSq7LO6Gm/Gdy8RXq8nW3G346SujuV7POfxaz8xVo35Oq+t1ypKOyrG/H8ccXCf2VupGuf7cBrtpVN0nYpWRMZ6qNIPDwhaXFtOSKR9m2BAscPFBTWxHfokyCVLnI2cCmZBLcUyX3FldMnF5HEhiJJbanCLmIkTfh125I12zIvlFHkaFZ1Slcq6eHbVF2r1R5ukA/keHSs8/Hf4EXRbEvdkV0PmMzmbAHPV+oTnUNrbAan5rZoKHuTHRdOGKCN1jQcDUTR3JSkODeV5amsBu1mGUjxPv4nPOP5cdvyPJY3RaMviHhSmPwu+0oa/mM12UfKcqchRDilvCoRriQycAaakNL3HQKHDBjlXiFcGvQDOcwO0XwIJO5ZJH+kFCljvPMO7x2N59Z2U01NqusPqwHUs2VdZ6+3/skEicmeJ/BN/QSOvvUhT5iG4pfA+XUkmAZ3spFqgy3LoBDk3UIvt7dvTpLN75mo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHhLS3c4d0o5N1c0d1p5aERvcFgzK3ArK2RPNnVYWlFxamJkQXNFeHEwVmlF?=
 =?utf-8?B?VFIxS3NQRzcvS1dlMElvaGtJQjEvam8zZzA4cHNmVlQ1ek5QSTFjUnVTT3E3?=
 =?utf-8?B?S2N0MHlBQTVvN2lBNERVNE5Eb3MrK05ib1A0NVhUcE54RWlyL2NzZ0U3S0c5?=
 =?utf-8?B?ZDZXSDFzYmJReldHM0tJanlHL3NpWHAzOGltdFhXRXdlcVlIcmdTNW1mWno4?=
 =?utf-8?B?UVRkdlRWZVZQR2VxQjZTQytqR2cvMnlDUktiNlB6amNiZVRkdXJuWkdRZ2pN?=
 =?utf-8?B?NjZDYWtlL294QzlrZTdIalFQZFQxenhxQXZMQ1hHWnRwR3IzVWM4ZStsTG1K?=
 =?utf-8?B?b3Z1SWVsRXJPbFA2ZjJqN1FJa1VNcGFSV0xEZzJUWTRxaWQ4WGp6RklPbytI?=
 =?utf-8?B?QkhDYUpYMkwyem1CK3dZTkdQVUgwNXAxbDBDWGdtelhtbm5QQTBrZjVzYUpY?=
 =?utf-8?B?Skw4OUg1M1FFeXhTOTJHd1FQS3ZpMFh6RWtsR2cxQVRKSkJWRlRCUC9SaW9h?=
 =?utf-8?B?ODdGU0t6RW1RejNYU3VnVEg4cEw3STdJVHZTbXRaTHJTNVFXWGZwTVh0dHhw?=
 =?utf-8?B?bTFya1VmVDBOdjRwU0ZtaktMNUZtM2hnOHM3NkovWDlOcXlkY3cvRE1aSU5Z?=
 =?utf-8?B?ZFVHUERXcU5MR0kvTW03Q3FMSzJWblJqZW5wK3d4NERoSVdYUUE5VmFyVjR3?=
 =?utf-8?B?TnJYOTVPclJFdVFSOHE1Rm9QMUZmV015ZFI4WVBRdHNLZzFvQ0pYMzRnZkNu?=
 =?utf-8?B?WDB5N2Y3c0hmL2ZLSWQrdGNOR1ZyNFE0S040dW5pcGVXanE4NE5uY2RjZW5T?=
 =?utf-8?B?TVM0ZUtaM2JkWldjZDJjdGU0NTRXUit5OWlhNWI2TEQ3c2ViOGNDdCt5aTBS?=
 =?utf-8?B?M0w1Yk0ycXRMY1RzcWhsdVhZaGZPOFRRamc3SWZyUE1aNDhMM3llTnFIaGtZ?=
 =?utf-8?B?SlVvRlZvbnQ0aCtYWS8wVzlZRm1temh5MGJYL3ptNWlpUEE0dUcrSmdMbUtR?=
 =?utf-8?B?OUJYRDczN2lMM0k1bXhjUGR3TjdYREpUK20vN1I1aWc0MndYNU5MNjUzRFlU?=
 =?utf-8?B?d1FqM2pFNFp0OVRBRzVQUGF3QU5KODlVOWdMWGZ4Y2ZGcWdLQStIOUU3ZGlM?=
 =?utf-8?B?cmV1L0xveTlXUFBMeTFuSW81WXBkZUlGaURoK1N5NEJuV29JQWFYRnhxYkZ4?=
 =?utf-8?B?WllTQmc2RW14WW9jL0FVTmtYRTVQWFFFVmgvUEsrQTVpdHhjK3g0Q2JOaXFp?=
 =?utf-8?B?NkN5UEtHVWxkNUxpL3EyWXprT3RmWnRmZUlWYXBGTVJJR1I0Um9nd1NxaXA3?=
 =?utf-8?B?TGEzcDVRNkxaUGxrbUtvc1VJUUlYeGQ1Sm5lNm5vZkZma2ZCRlBrWlFsa2cr?=
 =?utf-8?B?ejZ3Q0VNLzlpdDBIK3l2d0hsbFlGU005OFFRNkR5Mi9yRWtpSllWd1liQmMz?=
 =?utf-8?B?MGNZT0lpOTliQlBJcGVZaUNDUlUxdWdqZThDLzkrajlaOGRQWWI4RzEwQVZD?=
 =?utf-8?B?d1d4TitEMjZLTERRR1Y5MkQ4RGNmQmVjYXpGUHpQNk9hdFB1anUzYS95cHA3?=
 =?utf-8?B?YmF2S0Zzcnp6Z0t2R253OEJkdm9KK2JUNHJKNm44TDBBd3lnWG1PVm5QanUx?=
 =?utf-8?B?Ynk3NVpzNThUTCtqbkRZQ1gyQm1LNGxZcXpPdzF2aVhlMDYvTmpoMzZ0U2Zx?=
 =?utf-8?B?V3B4YWVNbVdUdzNtQnJnQXZPcEdKaHlPWk1TVDhnY0Y1NXM2Z2U3akdaaUMv?=
 =?utf-8?B?aFhQNzVyOUJtOUJLV0J0YjNPbm93aU9HbWNIRlhidTlMN3dEeFJxQUdPZlBt?=
 =?utf-8?B?RlRaRFd3MWxlZXBnL0RWVzB5N2c5TjdsZTFKU0hMS1NqZjM3Q0s0YkRjekFa?=
 =?utf-8?B?eVlzT2l2c3MwNmFTMnZManZ5NGhrdTU0eUtkMzRCK3VQK3BMZk5zdVc0amtw?=
 =?utf-8?B?d2crdGpNSGxqcmF1b2V0ejRrZk5aL3hVVWNXYkRaeVVmTjhiKzZ4N1NoUkFw?=
 =?utf-8?B?aGZweFVScWZNS2tMN0tmSVVadU1ob3pYS1NUN1JkY05pZFdRWXNOZWZXdUd6?=
 =?utf-8?B?aHc5QVE1QkZzUzdaMW1VaHUvVk5VZFVaQWZnU1FCaTBvWXdUSGIwSWZYRDU3?=
 =?utf-8?B?eUxZMzJEa3MrN3BPNDlBSzBhdWJKajUwNWlIWjJoV05OYjE1Sk9OMzdmcFUz?=
 =?utf-8?B?Nzl6TmZzT2syeWo2T2tld1l5VGp1b0k5K1loUG1iY2dqeEN3ekJHY29ib2tI?=
 =?utf-8?B?SDNOOHlEL3NOZmJaSHcxV2src1RoZ0hxUFpHWWJQZGtHeE91LzNRemlBT0xq?=
 =?utf-8?B?M05SZUpoTXNadkFjK3E0ZkVuVDlib3Q4UUN4eXZuVFR6OUJ3RDZLY1lwazZK?=
 =?utf-8?Q?YL6ycrxz3NMI7V7U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6d1ba9-8cf4-4564-d705-08df496998fc
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:56:39.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZdqFltQUPLi0kZs4RIIOMFjInB3A1AOgrRk3rPXb+QjCbaBE48NfW7bylMRGfAXuvximIjcQOmo/gWQZ3JZuiCbsfPyhDZn7JK2F9vvS4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5199

> Can dl_task_admit_cpu() return an offline CPU when p is asleep on a CPU
> that went offline?

Yes. In the top cpuset, or without cpusets, the offline does not remove
the CPU from cpus_mask. v11 will also fall back to an active CPU of the
mask when task_cpu() is not active. A new case,
hotplug_asleep_setattr, will make a deadline task of a task asleep on a
CPU that went offline. Without the fix, sched_setattr() fails with
EBUSY. v7.4-rc2 charges the root domain of task_cpu() too.

> When p->dl.dl_bw is 0 and p was moved to another cpuset partition while
> asleep, doesn't task_cpu(p) still point to the old root domain that p left?

Yes, by reading. v11 will check such a task against dl_task_admit_cpu(),
as sched_setattr() does: the CPU the task runs on once it wakes. It
needs a bandwidth that rounds to 0, so no case will test it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
