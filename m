Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795095580;
	b=y5RuK7/BxVwn7H2wQ+Yf+V4rKnBPa4U0WE7/uuibHWCFYGVQoFo1rUnE0CA3ajQKZEeO
	 RhinzIFLxZYhcJmIK+xZeTtZ4/NiqRWRBWo2YVJkex2BIKLvd8eqtIhCU8PcYQiXnl4MT
	 dteL9wNCnMi0+ziWf8XHJO8YsBntHwxvzoLN5jW0G3oRnxvXs7m+G8Dv29sEcOmZplMt0
	 MaxonR1Lc1PZLhjyoNLlVDGt2SAfzFERJbhq9aT0KXvptElV/jLmZq2CoviG/8ypPxa7S
	 3D2Di6Tdc3OLbjpsV0okkOf8bFm1c3oXbeLrR6ko9eU/zNGbe1pWQ5FCxUyZvAyznVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095580;
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
	bh=s7nIewrtkSEcvAkXEdc5F0wk2emtmsVMxr/HyQxqMgU=;
	b=zU7lsxmt7hFwxA58xrCMbxi1bW1WCnpacW5ve/b9px/BeR3HecrMWdQ9lE9wiqDT4v2+
	 FzPXa4RF4uORkcKUzs0a1/43GDT69poeI7WcJb0tqNWv0ZaadvNEp6hiRWL4G4Xc5S8hr
	 5fkVZoviK1slQbpig6BDDKB//AvuMs0J+hlmrAqsAJXtBwA6IB/DlZpW7tuWwPxIVcaxJ
	 JzZPn+2oIGV+SVOqKBwt74kjOUwksLhpl+CVfsxNtissoDhpfvmrtGX4RCDSRRcfKrXAF
	 2mAq/pUXh16/jIIBBaFoFNwiLOlalsk67dn438QEFU5cTVxrX+2bX6wgB3NpJYYXZUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="V/gO1d+5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.79
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020079.outbound.protection.outlook.com [52.101.189.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8915606A324;
	Thu, 19 Nov 2026 13:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8915606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=V/gO1d+5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8nH9Eh9tQ+kxR4TjT52Ut5tWUaBuBA9D0J+NjJDqpHXDVqrNqkA2PcyazJ0pRY3b2ab9NpPiWut+hAc2PKYCUyRkndyUCWPMNSqnxHgRb57CDMaCzGF+CgUKYOVIKTDd7U0C0+KiAdhe1cW0MYgwT3i8Mj4aTZy+HUYwPPgHGH1yCEdXz9dtrRdcYNFsHtk6rHZOTtXREKWPeAzoeFHqbPVut2DAUMQKU1lyI4YIAo2YAXLNaL06CqM9iLJzT9OM6MgV7/KubA20HNj0wgr3VXJENciqLLJ6BiNfFircakB7nlHnJ4aKT+iDcz5tCYxJzfefIBP4rylsDHOn1zLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7nIewrtkSEcvAkXEdc5F0wk2emtmsVMxr/HyQxqMgU=;
 b=MS+VCDOPR6Gu4dULx+MMAgzrl+ByMbJiVKdl4m0boIoeYo2WTvTcr/uxY2bcWHM6MnWwPuE+KkDgRvDS+5lm8V4HbS3QEzrmBJHkTWoU+/vY9Mo/51ZafYJQyZStoGgQ1BC2la43PpEU9+dSStS7VCs4UhUriLJRLnTQfjU2DuYR9P4Tiu0S+BvB4n45i10NIVIzaKG32Aqof4Gk7BSbPPr9kLxZzp7IhL+CrkoKw0uZzrPbKye0LJGMonno5Onyf8dwPeNBCwpKIGXQdLIVir9/Abrf1x/UeYdWLU+TKIwEjXesAg6BTe+xgdJkLfHCjy7DYiCb24MyFB15hlnjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7nIewrtkSEcvAkXEdc5F0wk2emtmsVMxr/HyQxqMgU=;
 b=V/gO1d+5ibkFLaJk2dPNb+4OhpFSf1H+mZQQrxEACKUAt71LCo0uhFjxFbroKUclL2bfajGE1vUKsLQBrqT6Mnfv6cZRE2J7bf852mtVLVZ1lMHzYQE6u9tf56k8lMGqvZ881fdD1BfhAJc1il1zbieO/WlqlnaUYcpnUZXcWrvzghfsIdCwBsv4h/bV+U5OAiuCDzgkz8wA2RD1pfI/fbteOdOMEwnJsGwmlL9oXzwmoJDV5ZwI+ZyFp2g82UR2KMtt6oPi5rkXNISQ/Z2iBPe2YIkQ2T1bm2xcc6UEA0zHBxrW92Gyk7/y6XtedcBVMdhgMEPEiRsG/0yhEsqL7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB11220.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:120::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 13:39:36 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 13:39:36 +0000
Message-ID: <8282556f-a7bc-4950-b7a7-b5b78557412e@efficios.com>
Date: Thu, 19 Nov 2026 08:39:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] sched/deadline: Release the bandwidth of a task
 that leaves the class asleep
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795037078.git.mathieu.desnoyers@efficios.com>
 <413baa5f50669ae464f504dbafeb504dd9b6ef6c.1795037078.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-222041@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-222041@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::29) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB11220:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e5e28b-8542-409f-ce7e-08df46428d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|260925022911599003|56012099006|260925021911599003|4143699003|260925021311599003|261009223027099003|261022105027099003|261026140227099003|261028144727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	M0dw3O5SXzsoC06A9s4YymbhRpGp3euC0ENf+1ZLW1YQsR0xni9WblVe7Vimi2g00XkUzh0f9kRv8xeVu+zri4rAg6KFWiuxrZzh9/PkfRwbosogRjOQ3rAfAAuHfI07NMP+4DCcsNHeiB1UbDDyO9Sl6dcnYpUYOKcgwResfD13oF8x44tkb+Cq8UktEZsBUhC095j+hzEOlrksEHdZx+Kl+pKd0tM8zFJj65ZKOClHoICGKjHIWIkbepS+yFfCVGpLrXY11Q8J9G4oU4wHluLzooR3a4ty6DDS2gAl0GxuPS/YAJATnAmtCf7vbvpXuuEdoFfBF0CJbfiEBNIC638FvBaj6oUvFPfnMLy9mLlUqnKqVolwluLAoNF5dJzdNBukuUpUiJ1bPlFWLtJzdwZU19iEh5Cjl+qXC6hNjRDjD60jNX9raK7WHd9xqHWaQLQ687r08Nc54kqz8PKaPjg4HKy2NzhBzHdJkCro/liHOC5ChB0/bVdC51o53k9VvQhcAtQQWY1ewQqEhZHAeOc67cs2G6mGfVDIahiZV20Ll+BSO+J6deKSGLPLyePpH1QTNKrrV47GoxOLC7n/jZkLe80b+ah22oM9oEt8w0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(260925022911599003)(56012099006)(260925021911599003)(4143699003)(260925021311599003)(261009223027099003)(261022105027099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFREd2J0RlhRdWtqNGtvRkt6ZTFITTRGVm04bXpBcW1rellXZWdQWDVNVXVx?=
 =?utf-8?B?ZzZZOTI5TTg1c3JBTDE3M09acndGTHRpdVdnOEtDcDRpdTZnMDFRbzdPc0pu?=
 =?utf-8?B?N0owenpzYWVmc09oYlV4SDNyWlBDMXkwWS9DWWhyQlcrRGNhVUw1ZDV2ZGJV?=
 =?utf-8?B?ZlRPSFJRSDdzMDhFQVYrTE92SDZEOGMyKzdIeUFpSTNqeitUTGRoaERWTUY1?=
 =?utf-8?B?QjR2aURYcVllbzNERXM0SHQ0bTR6ODJpQmEwckFCa0pCeEt4S1Z3eUk4NDR0?=
 =?utf-8?B?dWhqTDgwTm5yaXErSjdRR1J0Ym01MGhMY3JNWGhOTVg3b2RndzFGYkZnMmxh?=
 =?utf-8?B?eEprMHFKbUtONmtXcHNsZk0xOVBVekJneFRkY2tqcncwM2txR0dOMGlCUDVT?=
 =?utf-8?B?UUZZcHRrODFYOTlyUFoyeHVHd0tEdG5Zdko5THI5TElpSEs0SlJMRHUzMUZN?=
 =?utf-8?B?RFloZWt3alJoV1BSYTBuZjFEZ2hKTHAvSTVXTllsaFlzKzRHei9ETlVmNmFS?=
 =?utf-8?B?R1JraVhpRGRoWWJRa0pxR3JZSlhVOGtjQW5Bc3N2bGFleEhLSFUrM3BTM2Zw?=
 =?utf-8?B?RjJwd24rb0xzN1lKMUJPZEhLenFWSHoycEczaWppa1NBMm5zMm43eHV2eEdE?=
 =?utf-8?B?UlpJOEd2eUF2Zm13SkVSb3V1RTVSczd3Z3pxNmU2WTBvcFA4blk3dFdSMGc1?=
 =?utf-8?B?YWVjL3NoZVprMHdiK21STXg4UjFKSUd0elF6aWZQUUx2NTFNZDVuNE1DREVl?=
 =?utf-8?B?QWZSU3Q5WmsrN0ppQkphUk82UWhyWWIzbkUrWXgxMitoUmhTM2ttM2N6S2da?=
 =?utf-8?B?VTFhQTBnblZoSGRSVDhSb0tOR25rV3hqeDJTQ0tCVUNZMEd4SFk4MU4wQk1j?=
 =?utf-8?B?clhKUjhVSzd6eFgyTTJub1dOc1AyVFNLaG9BTllmeTRNT3RzVFBZREV0UFN0?=
 =?utf-8?B?MWtyaWpPTzFVWTRYVzJScUtVREpLMkE4ekd3dmpTb0svcTROV0NHdU1zQmUw?=
 =?utf-8?B?bHRVMVRSWUpSMHZXZ2lYT1Q5bUZucXhiM29wK2RuMTBkYndJY2pBWUt0OE1N?=
 =?utf-8?B?RXRHNGN6ek9hNzcxUlJRY0dZU1Vyb0JlK1krTS82OWJNclJMV21PcGpMWi9N?=
 =?utf-8?B?aEZXdGQvTGNpZDlkYk5VMGRjTzR0ckttdnVJakw5c0lJMmRjUzNYdHNNd0ZC?=
 =?utf-8?B?SmN5MVNBQ0diUTJFSUJYL3BBbjJ2M0F6ODdRL0h1QlBlZU9NcjZJL1o3cHBq?=
 =?utf-8?B?bTA3QnlFa3Q0T0p6S1lIZ1BNYlYzYlVqeE9LWjFVMWY2RW9xWU5PNFo2OEFZ?=
 =?utf-8?B?Vmp1cmI3cDRWSjdvVmIxbC9YZVZkTTJCTXVSSUtnMDBQTlo1VjA4MTU0dkFL?=
 =?utf-8?B?RHNYK3FBMWZzaEw0ZVVzNWRsRjk0ZHJpWWdDS3N4eEpqTGZTVzlHV3p4ajFM?=
 =?utf-8?B?cVd0M3dlSnBXRWhZRDY5bHA1TER3ciszdW1mS3J1NXRXUFkvbzMwTGZUOEVt?=
 =?utf-8?B?YlJ1TEVpUjJRN05zVUIyaDVlK0l4OThwZWxFNkJYOGhURk1rekV2d3V3TXlD?=
 =?utf-8?B?TWI2M3pXZjVkQUU2TWFKeS9LZlFoS1NSOUo4NUhDN1M1akoyQVR5Q3Vma2l5?=
 =?utf-8?B?TmtGNDB1QWpaa0ZZMUVZb3lhOHVXOVBQbytLRmJWSGc4U05kNDBXVXZCV2I3?=
 =?utf-8?B?dVBZSmFqeWNoZ2lzVmxybWtTSUZmT0NHTDJObERUN3I4ZmF2U2IybVl5WU5s?=
 =?utf-8?B?eUxod1NaZWttOGxLYlg0aUN2a1ovQWhvSWpwQ1VqZmdpZURuYXJqNHlJbnly?=
 =?utf-8?B?NnJCejNPR0pXVm9NMnNabHhQYXlTS2pSaTFqSGM0WndGMCtxOFFvVTduc2dM?=
 =?utf-8?B?TlRMRDloWitMQ0pEaDVadDhQZDB2N3EvbUN4VkZJT0ZBZXlkVktHSzBtTnNk?=
 =?utf-8?B?NHhWd1h4aEJJcm84UEhFR2cxNm5yc3BkdC9KT3FJeFpOcUZuN3BYUW5SYUFo?=
 =?utf-8?B?SEhNUDVqbVBlZkhjMEZOZUxxU003eFo1UUF6cGxOTk9XMmZ0aXdsVzBhS2dn?=
 =?utf-8?B?WmRVRXdlT1ZFb01NVmxlTjd5dVYrRG9mdWZVeklMeU1mcUVqY0c5QWxrL3lI?=
 =?utf-8?B?ZnVmSU9oVW84MGgxSVBvc29ZaWJDNDBDOVZ1dzVPWHlROHp4NjRzN1pqZk9z?=
 =?utf-8?B?NXU4S2RHWVRpVGdDVnI2NXo2SEV5ZWpDeXR6VGFqZ3o2ck5TenRidGJwVEtN?=
 =?utf-8?B?M1JZdFlodXFEc1hCNjZEcmdpd3B5ZkRWRG5kUFdmZFdaeHVOaTBFczdIY2Iv?=
 =?utf-8?B?US8wMFJ0S3dheWMzOWIwT295RUozY3BkWW9PVGM4cUpoV3hicU5TS0doa09N?=
 =?utf-8?Q?3eT6TJtwK49S3f0R2kHO4DUemuwhTRH4CQR++?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e5e28b-8542-409f-ce7e-08df46428d43
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:39:36.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InsYGHz2YJsVJGpl4fxJ1/6u/hfTJe/+PbUHoRo6yrhgBHnJ3YzZpWPk1EgeUZO28BrkkoDsB6Miqj3SOUCncec0w0wvsIyeUq7uMBg3thw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11220

> Can task_non_contending() compute a bogus zerolag_time here when a
> sleeping task had its deadline parameters updated before leaving the
> class?

Yes. The new parameters take effect at the next period. Until then,
task_non_contending() mixes them with the old runtime and deadline.
This is older than this patch. A task can change its parameters while
it runs, then block. The dequeue then gets the same mix. This patch
adds one more path to it. I will look at it in a separate patch.

> Also, in the same calculation, dl_se->runtime * dl_se->dl_period is
> evaluated in unscaled 64-bit arithmetic (unlike dl_entity_overflow(),
> which shifts by DL_SCALE), so valid parameters within the default
> sysctl_sched_dl_period_max (~4.19s, e.g. dl_period = 4s and remaining
> runtime = 2.4s) overflow S64_MAX and wrap the dividend negative, pushing
> zerolag_time past the deadline.

Right. This is older than this patch too. "sched/deadline: Fix an
overflow of the 0-lag time with long periods" fixes it [1]. As Juri
suggested, it will come before this patch in v3.

[1] https://lore.kernel.org/all/0863470611fb7fda03d12c4c12cc8e715476d9ae.1794926626.git.mathieu.desnoyers@efficios.com/

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
