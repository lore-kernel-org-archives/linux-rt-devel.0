Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.99
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150243;
	b=ydLCGeCsnSyPmySXU4I8+OZM+5zSEvBIUXTK1/TcnXme6bJYVowEJjumdnOuJ+ySNT4J
	 bNCf0XCSFiULrknPseH1PT4wr41wm3WeVvaqsRa4giFHFijNJMGOxPSSMEPDYMEzCZBS5
	 fOmhmThx22O0jRNPC1yISAC9G0qShDzVWhlOBAg9qYXC+rb7YOn4pz/+39uKk7T6iKCCO
	 /TMA8TfJHEZnoHTg91EyExueImlGDz2npEjcmODetn12FycvW9N83vX3IxE+PpcX41+Ky
	 J8ASlVQFXXWAdsS5tbmXOA4+xpPcehWnhBvXkEnKNfyar/HvX69bkaAnQhNTZzDLJBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150243;
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
	bh=xIKOuxci19l7Tq0o+ugG2noHXSXVthcUqvcEHjWiWxw=;
	b=XVV7RfhVsxo/mNkgW8kmGTyhGwsNyXCEnwM/HjO7YmgG4J2MqkobZi0bCT4qrp8khu+e
	 CDqgDy70CYSmR8lF7nPeCmk3QO6gmyDVkomm4s73uAUWAgxJkG7ZLx5zgS1PvIBcy51pn
	 0zt03+Gqvkt8IToteZGQLC1olnr2RnVOym/zQB9hZIYYxDDqWziJMEHCG4OMOAI+K1sxG
	 e+vlzZiCPC6s87sRgwdr/DJdEcrLCfi11fnHLgGIe8tUk0BNB/jaDwFBh4QxUae1Mor91
	 seUYtlHzsa1eO5cgvUfIAy68iq36RJ0TyYZ4Wl3aPymBmlw7C3X+WvCjrOYVTOyyP9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=LjVeXqLt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.99
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021099.outbound.protection.outlook.com [40.107.192.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C1606A320;
	Sun,  8 Nov 2026 15:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 158C1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=LjVeXqLt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qt+6sqPcz0PTiTVl7rKV35BydYFz6hwwY0RY3/wyrRy4+rnZfCNbyO8NmayIZ7pBYHbX6EkZHyXpMtLdMadfAN51XhKeLsgSPRodctRE9yJz5VHWD1AshxiPVcdONMoaX1TPEU9ja173UmLqCeSPAQZjU1YF0UKww6Z1wObPtzsvfq23uI6OUwCQmHwTddqczeDcXH/giCBddHF3dJQFDksDHonHKWbzE6N7mvrv30lH0Bs27vciXnL3GJb0k+DMnoQJB/MLsXMlG2rupNpo6fgafeq17KwiZV9r5YlnMgPgP0Heeszh3NP54ZXFV/VGU8vNZR43hzX9D19dVx1+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIKOuxci19l7Tq0o+ugG2noHXSXVthcUqvcEHjWiWxw=;
 b=Gl7sJRwXw9d+3zIM+7V4quabmZT+V6pqL9v5jtUuc+soe7J+wzK2+G76hbQYmP2Z5CgY/zqApJ5MoXhbN65slNYwslzdkqz3xIfS3Rq0mPatFWm6WYbxnu+eQz7zV/++Psm+bQh7xfdxl/S/5Nl2oAOdIYhD7d377X/J/50JHChzRaYbdPYB2Ki/JQ2WSWFy0w2/3/e9b5kDHsp1Vf/KxHtRelZ1BsrkCxuB4QeFnu8AVvGAONw/uEKI+3TPIdPGsG2yIlSpAwB1hu6KljP+0GCi+byRe5F3aLdY3OCtMqkD5WYwhMAQ2rZ/GbsBrwk6nNwHPp7RR7aYmbW+MOkGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIKOuxci19l7Tq0o+ugG2noHXSXVthcUqvcEHjWiWxw=;
 b=LjVeXqLtRK3uc0RN0Z5BFZtq2YCq+zGLlfOkBEN4l79iVJUY9D9zJC1WeGFsWZ2lp+EtP3x24ZkBLI/rzfzwueNxC7U8e50oyWmR8+aFHI63Dkcq59QXEXuiI+dxJ910//54l0DZO2keZl1ml1kz7tOd99oC4hk2kVPfeWC7l5MBNNuBE6JQ5ldGvvBhwE8nktGcGiAJfbq+xnrcwwT2KgBab8SLu2JmOoS0drhRi9rCB1uDqsYlahVON0YqqU9B62RVtnCAdTszKy9IOuVZcrGJIk0nEcoord8sokW76JFdgen90DjeEWMtLwCRvjuxdSXE+jnoJ5nlpsEv/qnrHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB373984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:03:58 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:03:58 +0000
Message-ID: <d33259d3-baee-4280-903d-2ed7ff34a54a@efficios.com>
Date: Sun, 8 Nov 2026 10:03:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/26] sched: Let a task boosted by a deadline waiter
 change its policy
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-5-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202487@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202487@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::18) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB373984:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a302992-a2e0-4d08-5fd6-08df3da98446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|5023799004|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i4N9Yfhde5UuEFAQ8aqNa4OwZsoIIEihjrmpPMMNk12cMfBT0r1bB2DrJJloe6YsaEHNnyhGrqSCMQCfA3SKW4i3LG6HZw2Of+CiKNr0TjSyZM9AYQhtVgGe4wIbBP3gpa9UHTCxPMxlPc8tAiCXq9yR7MIl14EognG/qm5flaePxAosog7wfKmRINWykYDQ9jsNkBtY4rjruPYHb5IplMIMj2lkpRYva8CDvCNX2RLk9rLmvdDw0mfa85fTY2e+PuHc2toTdvaG9f5HuQEo5N0URIwVDcZAtiQSqMJ4GwOpyN+bSX0kgXKAYbsrafT5/9jFTHN7AaIAW6fXO8ujtdLil7V0TWs/6W8ED2zI0nuVdiEvJv5NYgHdN4J/JTfjI47j+Z+48F9MLbQOcLtY9oinF9Jyh6UEWUoSFaZpg9QVOPceuO+jkcmjqfdLgouK/owHpIx4bGvalWSulGrgc80bEBYKcgDZBM8xxBvmr56SSVyQGRgI6t59ao6rSNEOdGF5epYu1CxTvDKFn2uwkUkFmWMdUId0YtMSgu6YUYNax1xt6q+boexXDKWJ64yrDdEsff17q8wuwaGWVSlrxgjpUYfLy4wePbeW+7Um714=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEpzQ1Fpcy80TFFBMG00bUM5bFZRaGVmWS9MWTJHeS8waDFTRlpPYzFlNjRV?=
 =?utf-8?B?dUdNUlZlY3gwck9MaWwxcWorWFpBempLZTByZXRWQXBtL1B4T3k5amRNTGQ0?=
 =?utf-8?B?L0xwbnljRGI5K3pEQ1dCaFFtUUxPeEFFejJuRDUvVjdCdUtISjNYNUNqcDlU?=
 =?utf-8?B?S2lUcVVHNHRncFA1K1VJcHMySVlFeE5oWU92RXh0V1NpOVdRU2hvM2Y2WjBJ?=
 =?utf-8?B?N3RDcitMSDJTQWxKTkNxMkdpT0hEZ21hSzFWNVA5dm56ZXcvM3YrMTZrVzV4?=
 =?utf-8?B?VEY5bll5a2J2eUx3Q1FhYnR2QzFjMldudTIyblNiQ2xISUltMnduT3Fnc2ZB?=
 =?utf-8?B?OTlJaDIzY1A3T1NyUDBuang3NFBZL0M5V1ZqdEhzMy9CaSsyd1Fkbk5vU3JR?=
 =?utf-8?B?VG5XZ1pGb0ZYN3EvSTlVSndpWnBReC91M2JwUzZRdjFFeHdqTC85eTBSTWVW?=
 =?utf-8?B?RXlsMDNEMGxsdVpKdkxhRGloanJLM25SYlZWRWppVmxBZGpHcXFveHpieVdU?=
 =?utf-8?B?UUd0NDFQSkk4QXppakd6Q1NMaHJyeXI1akM4Z0RIU3QzZDlqemRmZ0d3TnJx?=
 =?utf-8?B?c2toanU5ZW9pbFBUSTVNL0lDY2Y5S2EyQ21pU2xLeVQ4SHhROTBGallEZEVu?=
 =?utf-8?B?OElIdTUyTzlyVlZ1VEs4NlMyaVdsTmNVeDFtMDJiQnpqeUs1NkE4WWRBMit4?=
 =?utf-8?B?S3h0clpBYi9rdFM0NzdXOVZma3pWTDdvL2V4MlFSK0M5QU5nVysrTDR2N2c4?=
 =?utf-8?B?cVc1TU13aUY0VmNhV0RkWTFFSldIQmJMNk1KVkFEWVY4TUhuNCtBQ2tYVnBL?=
 =?utf-8?B?eitzMDMwVW8vZWZUMXgyMzF0UlJNdkFZaHE0Mkpia0hYRnBTRWphTEo1SEtY?=
 =?utf-8?B?VU9lakVHZXpwWWhYZkVPV1AwQTcyeFdqM0w3SmxIQ0EzOGtuTWx1dXdxZ3pt?=
 =?utf-8?B?SHJ2Zm9GeEs2aGY5c2lPL1pURFFvUGlpS0tZUytqN2NjVno0WGtvMHJnbGRB?=
 =?utf-8?B?WTlOQ3EvNkRyTWI3akxSdEErMTBzaFBzTzJQdkdGZjY3VjhCdWlOODV4bDVH?=
 =?utf-8?B?MWdrZzRvbXlxb0YxRUQrRkJ1Z3EydVBHU0dJVGZnczR5dFJoQ29mNVBUMmt4?=
 =?utf-8?B?RERQNTViL3NzRnhXa2RXRGNjNUhjODdHOEdWMUxNQTYzMUMyKzJvTzB3TXZD?=
 =?utf-8?B?SXlidExWU2lOZEszMXdEdktObU5XQUNuS2xnS3BYOUlJaGYzU2VLOExhYnoy?=
 =?utf-8?B?V3lNUThmSmdnbUE3Z2VxNmJXV1JSSm9xWE1wbFJpWjNIWi9udG9IL29IbUxS?=
 =?utf-8?B?VlBIUUdPbll1Rng2aEhCWUpzYW51bDZZazUyY0Z5Z0E1bFhPOWxZQmphRE1W?=
 =?utf-8?B?Y2g5MjZUY3pJY3NGakkrb2hLcDJkb0dCR3d3SVVuQktOcDF3SUZETmUxdVhx?=
 =?utf-8?B?Mnd5Mm5LbGFLeDlqemNpN29uNzBQSnZFMVoyOWljTkkxbjJPTU0rTHZCR21H?=
 =?utf-8?B?ME1Tb2hEa2RGV3lGTTN6T3VwWlNhdEJmWktITGl5aU9LeCtxcGc1N09LaDls?=
 =?utf-8?B?RVN6M0lrZTdDL1hWSnZGQjlhR0ROYno4ejFqQ2E4Qm42VHp1dEtDRlhLeS9U?=
 =?utf-8?B?aVdwWWpoeEZKMFBtVVUyaFg1bm1Ubzlpdm1KNFFNVjNXTm9Ga0lHcC9ncDNt?=
 =?utf-8?B?dHh5MGJlcnV4QWJFU2Z0czFDVlpEN3krY0J4T2E1WkdpdWZyRHlURndBMys1?=
 =?utf-8?B?N1Zic0JJbjU2WDF3dXdHRnRaeTZ5UUpPRXFBdnRyR3dYY0cvNG9PV0s2eGxs?=
 =?utf-8?B?cGxlYnRXKzFDOHdnWHZiUDVqeDRwcG9NM0orTXllSGtHd3FnOHFpblBlVUdJ?=
 =?utf-8?B?UmxlTFJHUVZYS2pVZk5nRGhSNnFOMGNRSmNBMERHS0FORWorcTR6UDRVY0NT?=
 =?utf-8?B?dFRvcVFIbDR0ZkQ1cnBRZTQ5SlE0VU1GZXhtWHc0NnYxV1ZJSFNGYWRMVnhE?=
 =?utf-8?B?Tm5ibmY1NzJFRk45akRreE40TFZPTU1oengrbzZMODhNcEl6UUF1S1dTZHM3?=
 =?utf-8?B?c1hrSldBUThGWXBjT1NuRktHbUd4dkV5RHprMllqWFhnanNURHIreWFFQ2dU?=
 =?utf-8?B?MFR6ZXBEZWc5MTgvcFdYVzczUDZ6UnFCVzR3b1dkQWRIWEV3c3dBTWUxS2xp?=
 =?utf-8?B?ME9jYWhQVkFjWHdabGpXTUUwdDlWMlJzUytDZ2w1VkhKOXJ4dWRmUUtxS2lT?=
 =?utf-8?B?SkdpeitGQ3hNaVNNNlRxV0xtQTNIblc3b1c5VWtSbjN4YVZpTzJOYUhDb1ZR?=
 =?utf-8?B?SnpreUdoUnBnZllCbndOY3o5U2h4WkZLZFF4L2l4MDVoK3lvYlJob1pHbm96?=
 =?utf-8?Q?GkCi5lKgVd8/oirg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a302992-a2e0-4d08-5fd6-08df3da98446
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:03:58.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6tyLxfaiAk4tWsi+5VHjMWMgI2NIDLfXSIvDSGgZcWM2ucesIM8iWfrHJITvnEo509GzGV7leoV4Db9mpCGrf1I8psvV5p2o41c5pZLDdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB373984

On 2026-11-06 21:13, sashiko-bot@kernel.org wrote:
 > dangling pi_se in __sched_setscheduler() when pi is false

Right. Before this patch, the call failed with EBUSY. Now sysrq-n can
take a boosted task out of the class, and nothing drops its boost. v5
drops it in __setscheduler_dl_pi() when the new priority is not a
deadline one, as rt_mutex_setprio() does.

 > unconditional ENQUEUE_REPLENISH in __setscheduler_dl_pi()

A boosted task is not throttled. update_curr_dl_se() replenishes it at
once when its runtime runs out. enqueue_task_dl() lifts its throttle. So
the owner already runs until the unlock, with or without these calls. A
call only starts a new period: the deadline becomes now plus the
waiter's relative deadline. That is never earlier than the deadline it
had, so the owner gains nothing. rt_mutex_setprio() does the same
replenishment on every chain walk that reaches the owner.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
