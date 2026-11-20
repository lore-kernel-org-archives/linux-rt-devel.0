Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182800;
	b=HZM3exinU6nMh2vBcVD53XPp88RWP6tp2dXcqYbChGLqMjx4Uy1gjcAtqgq/Vv3ESL0q
	 kPVUQqn3OQqUf3mp2e0rsgU9AUtw0zDkqcBAIUu2ryJ0h3W2kLSCON4vA/k/NqO5p9MiF
	 kjz0FG+baGgc8BkrIYcORjLNDgowd2gLByWxqTIfPuv45miNFUaJ1Q5UqeA1c1VVlF8d1
	 SnlIXdH7t5WKluwIyzg9OHYr1z3SQMYkuX17LhWsGucHn1psDPDNx6DCrIvbC9ct+L8pU
	 62cQj6Pe/ZEgNsSJ2I4OQsfqRgAUAvxPxkV5ls6fPXNgkZFNLL55AWAWpihGOjktNuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182800;
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
	bh=uOmHHEzCuqyU+4iN1p0XIHghyr6ReyKJQusR6syQdQE=;
	b=nAQFyVwTXJglWUyjaEzVDco3lFs8+mKxvbaaK+5vR7hjA7tEEfKOEqDkuxGhXGGTlWKt
	 9/wy2JTbALEkkrKyAgxyI29g1jEzWFFM2GhfRPIB1kadqHW2agAC5kwiT1pY0rAPuSyM/
	 2GOKtYjEEEJSsiJB17Xa347J3X2+JtUuXDtAZRQ5q7YB6Nle462L9qOf/wNXwzWs7Gr4j
	 9OZ8LOOzqFpxLal2lJlJICuikE581z+OmgjziSSvqcv7oIdbPXrqDYxH25kUrF7ZMDQTh
	 HxZNKmcMX79mjI8KQ0Z7YBzO6OGu/FJj5d3YcPEzFKR6b7B9RyYoCOmmsFTDAA6OvXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=pMw9hud3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.136
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022136.outbound.protection.outlook.com [40.107.193.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004B606A326;
	Fri, 20 Nov 2026 13:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6004B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=pMw9hud3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBVEzxHk8AgY2B2h4smtJnigN/Qy6eDxrsA5EN+9HmtPqz7rsqU0xU/6gTPKzTs/IOLuVGmazpFjEZmwMvVSoewsJbkUOMfnP+yCazO10S6cBIPECd4jFu8LxJPWnwUoMQsKT7SeVAZLEE0wAfk7YH0AAfqL2n1TK2Vb9PzGp/IC5dcmTcehDYVioz63e9CP9+wxwHGI9nMquKuVkA500Ome/xCraqGUbLSsMXkNwD6S39a8g445lDxArE9JOOxYGA9OAILd7g0rbGtJRlCr3RyTy3gtyu+36mtdW4EzUI3FJlLOIP6hVWSsSaMtLgalFX91a1aOYB/pZIaElxcKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOmHHEzCuqyU+4iN1p0XIHghyr6ReyKJQusR6syQdQE=;
 b=oIo2HcenQ3PnNeyAxyQpJjXvSJ+MhoY5B1q9+vuPCzmT/1Sj/fECnKmkHmungybn+PHOS+xK4SGgy6Y1hT4Gf/q7LXQe4fmSNp/YDvvXlerMo5Vp0jiGmu5MortHbt1bs2zi5hmKUArm/lP7QkS96kO8Yv+tMak+P2vMekorVfhwSeSIuOhHu3Z2gSYlvuEvyKbH3Pvh866WB28q+I3T4VxOEwCQlffS2d4EURgRNN+o+p0qoP/CYDNp8o8b6jZDFqET8adaJ24NT2wAe1ygX03CTOrRB5nFGurhFD8Y1/NMK43Uq/u/PUb/ObbcNGqNFls6vM1UhbMrBZgz0U26qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOmHHEzCuqyU+4iN1p0XIHghyr6ReyKJQusR6syQdQE=;
 b=pMw9hud3cR5SKc6fcO43duGK7poGk7GzO95wHFc30+KMMRSEJ4aft+QKIuqgCtakdc/ipWUfOdIuVlf6kRaSCL3XfH7TmM+PJEoIRhQhhA2ULUKaU5ErbkpS5LPatruyGMmuqifCBYeNAYMnA6hl7aCIVlxNC0guNclFUrnRUQC6/y6H49H7oNrwRMFKauGdhnPKAZZoH14v3MOr1ullalzACwnuWzUgLXtf5TtTWPpNauoio1VTIvtOS0lUEc6RnrmfwEiy1hJIFcnXWWotD6zxihcxQhWhGkBgbZ9OKeWM1C+ey+I1/gqSkNNepfw4qkGGix5XpfRruvHSQjPZRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB11587.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:53:18 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:53:18 +0000
Message-ID: <903886fd-8512-4dd5-a9c2-d2baae4755ad@efficios.com>
Date: Fri, 20 Nov 2026 08:53:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 27/33] sched/deadline: Start a period at a deboost out
 of the class
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <9663a1e69055f16fb3e828fb0b47cb79dd020439.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224049@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-224049@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::21) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB11587:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dd3da5-7149-4a12-0058-08df470da1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|261009223027099003|261021121427099003|261102123227099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oEKcW2PnMhbTfzO9Du0eyh2rpO4dlioQmIWGfE+ytUVQodPNRad654kCnjr59pHiWU8xSg96tQGnkIN6NVHPJVCsjHuloIi2c3TMwFQ7BUErDy/LuMAeICyDbw/LVIqA/F9zDuxHmIasS3ewYp8vy5PNkuhdVktcLxgNoe9nWaYiLYex3n5QKIUEXRnZJZ4iFX9Xvt9K5/MEQ2gUyZNgBDlqpnTfxuU5WvEuQYtVMxeXB03qhxtYjUPvJe9ZsihGBFSYgpKm7JPgiwRfXIZ+BedfT1zmV1K/NuWL4QyqK9MWLDowkDB/1YH/beZSvCcbBruYiW1wImqGFhXri7kkJatE4+tN/pcbb4PVA1id61csChE2GlQzG7IAH8uN2lJro2aHzkV7KH/QuvZtma7ZtUu+t8q6movN8f54Tr4Syy6dYfASzvvQVaetchfqgdjrJ3OeRpDkL7MfWNYRV9tj2I0BcXmGdXFq8/qgfc7q/p71LRTK5vMwT4c2sVoJE/9EsGe/vQEEAsczxkANruiwm+yRvoyjPADPgaOKQao61dOW5FwTgL88xgQDrSgVupziB7k7Jc3hPOlUh7ZtdyE8WxTVdlQhHp7g1q7EWLI0HTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(261009223027099003)(261021121427099003)(261102123227099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmowTzJuT0loNzkvaGNoc2QyMzFFTTVzY3kyenIyWmdnOXhOZkhlbFV0SmdW?=
 =?utf-8?B?cGJsaTdCWTNNS3RiZTJCZmhpVU5QNHNwcEUvVUhreVFYN0dxczdvSkpPS0M3?=
 =?utf-8?B?blFaQW9VT2h1cXhLTFY2NHZta3VMV3B4WVRNQ0pnMExtTU5USkIwSjRyT3dU?=
 =?utf-8?B?SEpuOStuanhFa3IvRXl5ZDVpc0YxSmE5OFFwd0hTcEhhR05oQ1hvRE5hcEpR?=
 =?utf-8?B?RWNUc056S3c0SXBZSnZTODUydGxNR1BFbVUwd01QWjhHUkIzK2ZUYldGN0Ev?=
 =?utf-8?B?MjBZc2FINldGdUU0SlgydlhSZSs5cXJveHNWck05WU43dkJoRFd2djFvZ1lt?=
 =?utf-8?B?dmVZenMvQnFKcUdjeU1iUkNSaVgxN3l3TzdhQTYvV0V1TGlFWUlVbm5XNDJR?=
 =?utf-8?B?RXdDM0QwV05QUURTcGYzd2ZQSUR3QmVIazlaNmxYNlJ0SmRJcUgwaU1HVm51?=
 =?utf-8?B?MVBQZEYrZEEyaE9xdGMrN1YrSFVTbXNvdkVVTUdtSWlXempzbFRCRmJIcUpx?=
 =?utf-8?B?b2YrSEJoYVVUTHBJQ29RODVlbDdoWW5EU1l5R2Y1bDhvYkpGbnd3SDhTTzEy?=
 =?utf-8?B?OThNVVVvbUQvQ0ovNXBma0t6NW5kQm94V3llaTdkWFhvdnk2OHNsT3NFRkFz?=
 =?utf-8?B?ZW52c2xsNjdLQk9ZRkU1dXBxc29IQ2xyU2xobGx2bEhGZFVreHMxeTZHTWN4?=
 =?utf-8?B?RjZscTczWlVmTUtiVFJsV1RQTnoza0VjNkdtRzlXNmpGNmlaVlZ0NVBwb3VL?=
 =?utf-8?B?aVFIYVpMT1BKT2dMeG9EM1NOT0o4ZXNtczBkSE16WW5WU1dITWpmakhKTVZy?=
 =?utf-8?B?TzdoL2FaS1R2eTlKazRITDQ4VUV6dFBCSSt3dStaQ0oycm83OGk0MUNhSzhl?=
 =?utf-8?B?RkM3YnZaZ2xSSjVWZldYQVBqYzJ6ZG5nTnA3SnVic2NmbEpYbFlLODJPQVNv?=
 =?utf-8?B?OHJjUTNxU3lIcDArMVNoVVhGSktkY24wTnZZYmJtYmNmRjdQQ0tmQVEyVTQ4?=
 =?utf-8?B?b1VCRHJlQ1lRb2ZLTVk2Wm5SNXQza0FxY3lmV0IyZytDZ2t4OVNPNkFXVVI4?=
 =?utf-8?B?RUVHb0xpSHVUYUFicWhDaCthTlFJNWd1S1dnT3FJZ2VFK2p3YUY2b3hZYmF6?=
 =?utf-8?B?YVFkeUlJbFdyVC9venkwMXh2QTdJdWlxNVJ5VDJxQXJ0azFvWi9leGNmTTNN?=
 =?utf-8?B?aVNBdHRKamN2Yzh2SVVrODNBQi8zUGk3QVhwSXJTQnRSVFJUNVdhK0Zwdi96?=
 =?utf-8?B?QWxQQWNQTGN3dmI1TGQ1MXdSNjFJalNld0FlMjBIRXI4cUw2QmlSL2UyRUpU?=
 =?utf-8?B?bk9zY2l5QjVHT3ZVVGZZTjU1VVFFM3BielF1NVNnRmsxbytpbVVoZDl1R0RK?=
 =?utf-8?B?eHBKa3IyT0pSU01BdUxWaWsvTjloejZRTSszTnZ3eHVZd1ZvMkNPNytuZVlh?=
 =?utf-8?B?KzhkYkhLR2toeGptNElNUHFzdVErcFVpOFNFaTBEd1dsNGRRTEg5VzJralJ6?=
 =?utf-8?B?blNVb2FoS2t2THU0NmNpMVRVNG9MS0xkUmU2KzFJZjluNEZocnZZTEhvdzdy?=
 =?utf-8?B?TFhOS2xYeksyeHczWDFjNldnTjVoOFloaGhhUWN5RVR4bVBBaEJsTUZtM3NW?=
 =?utf-8?B?Y1dZTlp5eEc4SHNJWGgrWE9jL3diOU1OQm9laDF5emJMZWt5dzZGQ3Y3YWhU?=
 =?utf-8?B?OHdpUEdvRlpYamplZ1dueHNwcmI0R0gvSGRVU1ZjUEJ4V3kwMHRMNjZaeDk3?=
 =?utf-8?B?VVUvOXhGUUxUcGdqYUV1V05EYWRRaFIvS09xVG1IU2tacHljWk5aanVuSDFV?=
 =?utf-8?B?ZFBrZ1NJeTk5N21sRmZ6b1MvZFo3bkZpeDF0ZTdleWFWaG1GbDk3dXpkL3hV?=
 =?utf-8?B?NHMzanBqWmNLMDZIVUtzVUQwajhMdGhFUlE5YW9FR3k1aFpaNWhUc05YU0Q5?=
 =?utf-8?B?blFGWlk0K2JMdTlsVVhGWWppNkR2QzIyZGxPSndLYUVwQnlNKzRoN3pTSmh0?=
 =?utf-8?B?cUl3U1MxY2RXUUxmcUo2cURobE5ta3IzdU5SMkRwZnRCc0NIbUkvOU9rRnNQ?=
 =?utf-8?B?TVprR3B3V0E4WmF2emFDSkxEUFlRVGNxYUs1dis5ZXhqaFkxbXhUZ2djeXN1?=
 =?utf-8?B?bGhvcEk5QzRINHVxemRxZGFFUGpLWFBhSlJEQmg3R0htbmVndTNiWDZkK1Yr?=
 =?utf-8?B?cGdqcmpZTVpzY0hncDlFdllpUzBGdXRpa0xiVnFOT1BqUXVXaEhBQmxFQ3Bv?=
 =?utf-8?B?UmRqTVl4b2c0VmpyZlY3bTc4V3lkYUZxZXFoakZlbmFaa2luR3drTTQyMEp6?=
 =?utf-8?B?a2xzTm1ZYStIc2pBUFVUNU5TKzBLZTJoRm80Rklkb0FCaXVINWdMVWlBRnV3?=
 =?utf-8?Q?cGNLg4xPL9ElzPqaQuO1cQoOtN6gLg5VEKBeK?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dd3da5-7149-4a12-0058-08df470da1a0
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:53:18.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxhH9qw0Y66VizFqHKgy76mdcrFEMfDQt4CUn8vN0+seW2gVXXMAG50nD88t5EakNd63GdLQplb0YH3uwvMQjvFAGJcAfy7ZXX2ByEKKKS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB11587

> Does task_non_contending() still arm a 0-ns inactive_timer instead of
> releasing the bandwidth at once when dl_deadline == dl_period? 

Yes. v9 will test zerolag_time <= 0, so the bandwidth will be released
at once. 

> What happens if p is asleep with p->dl.dl_non_contending already set when
> it is deboosted out of SCHED_DEADLINE?

The old timer stays armed. v7.4-rc2 has the same gap, and this patch did
not cover it. The task keeps its bandwidth for up to about the donor's
period.

In v9, switched_from_dl() will cancel that timer when the boost refilled
the runtime. task_non_contending() will then compute the 0-lag time from
the task's own period. If the timer is already running, its handler
releases the bandwidth. A new case, deboost_out_asleep_after_refill,
fails without the fix and passes with it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
