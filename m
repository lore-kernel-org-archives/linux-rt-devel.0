Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.96
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009338;
	b=Ln8fGicGR6kiJEvQC+q+yRTCDONQbbGiiRV+xLRTU/+adE99L9ggQFKPBzgH3MSL1fRe
	 DfN3485WRiFiZhrXM/aWltdgB5yIVtivyx9d8qVVCulUtd7dEVteEscTW24Cd8ssvpr3M
	 /tlr8vMk3lHiFWJv7/t0UXpjBfS0ml1CHwymTnEDeyrt26Vtud1kXpr9D0yVsDVXhOWmR
	 nfKV1r+Vqwyr0jbd/quQ/WAEbzBzJ66ODi67wMAk3Dut9neJ2Tb9yAUMI4YSOG91kptna
	 l5drnlghj+HmSFqO8JEWxGmZII4wRPbA/0jiyFpbrAgFxWqsFHjVuCR+WvZUSYnzsDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009338;
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
	bh=7wiJPg0wfq/QpaHxvUEQmjmlFggT6S86Esd6iCYh9t4=;
	b=RKkAFJe6It/yU9+QNPR80xc0wswDMuKAQXFONMzvHkSEO8oFU6oQEp9NB++jJmWflXuS
	 dBojv9+zs5ouTWJ5lh8yEKpDQ8XOSF+ql88loC5BRLdS3GjFMsD1HkapTgpmg93UoePKt
	 BH0NDjBPzJ3VRNLZViYGfqxtO0p6M/xFZCWfDxcyWf6xfpDrUJ5OV3InzDo+8v0/+YZxi
	 6BrpiuS8hCtY6dfu9PeHpMv6Dwbunggi2NtVAw6PZE4wq+1O35aox8z8Kb84eqUuMBI6d
	 DLYuuiEOUF55wCzoqYIi3/VnaxUuXJjNpWISEpDkzAuiRCVgIXqff6bD0qymUoDr60w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=ptM48ogD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.96
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020096.outbound.protection.outlook.com [52.101.189.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9751606A330;
	Wed, 18 Nov 2026 13:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9751606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=ptM48ogD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwaaJhX45jjNqiqUCgrob8jk3fOJaSwlYdREpmofaebsDUWNH7vdSxANGGZRj0sigl1MV/xdH2g7fS/u1vAm3ZySXrO0W90p5q62ALL7t4+6Rao9+OXgM8WRGBMZTkFH51bbwlPjvIw4hm8/0lhjCz8FaXtXptlbuO/JVNtM0obNgEaYdvdOvrCcmPROsLk/Vlg26OlYFiN6gD45GROvo8yBunEdc1pLlNbtN6FgAk9t0x9n85BVMNfiC9pz/fukfjBoHBJULG9tEMcif2duvusTJNaRgz1909Lc/6XJVktaD4+jGxbun/D3L7YGWQfFBakZrmCx086jnHoeXMWdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wiJPg0wfq/QpaHxvUEQmjmlFggT6S86Esd6iCYh9t4=;
 b=UvoNMFgGIKcE2iL6ZQTykpJFzfsBwSANw45Ft5D1hN2zBHY2tf2dHR8kJ6BTyaPeOIKzScZ9ZdSn2EwCYAOupH3OHsBrEVP05DnNrG1GjK7uade/NGXk8zpiYpGdyYMt+HTro4wwZe4jovW8srh6Igg0TlsClfDAjVMitvp3CvjK6WaYUtoWGT4QE4vqKB7FXB9QR9z4O58K8dXN3RMhQYS/DmeWcF4uUTusfZgd04RY0WThlHIsThHkxhVqiNZlnwIX93qao0ABIqcz6ixo/ZdMpSfKeAMys6UeugV8E0bOLPquNWkBID555FT2caCyGkKv5xTffngWm+SXhPt7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wiJPg0wfq/QpaHxvUEQmjmlFggT6S86Esd6iCYh9t4=;
 b=ptM48ogDPLfq4ETfLEWEqrJ3EdHZiDph/FRFU+s+gWeL5vOyz/c1puF9usMgJvv3ZZE76KttbPPv1R6bsR+cddSXJKJvFN4czN5a/Oz24wTDIBbEmHzaUPnM4FrV/YQ2vppCceomWwM7AU3i0XHK2D0OKfIvkbuqVqk6W2z0EPISlfc/BRc/6BgXQbZZuvHeMD0e9jU1gGSI1hEDxFvV5+BBFj2hL2lXTWEZlk1bcJmQGctAK6fZ6vnCSkfvEKZLQxUUa6glFnu7qDS24aZ9JwFinZSRJFQbxZso1OyGEDFhRCWRpERdrq2CKvHuyuIxq2aPvl21j3nAyRvWm255+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB8248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:42:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:42:14 +0000
Message-ID: <2c204d0a-842a-4e45-9354-a6e2343c079c@efficios.com>
Date: Wed, 18 Nov 2026 08:42:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 33/40] sched/deadline: Start a period for a task that
 enters the class blocked
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <263b8e16915845e823712fd5feefa7b79205f7d1.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219105@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-219105@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0297.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::16) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f7fb8a-38d7-48a6-7637-08df4579c100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|261022075727099003|5023799004|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5CO/QFsFr2LfiFR09sZ2kXJpJbnAX7Df0VUnqFBG+OdjTFeCClTbJ0HkuAPZxm6MMvGb/ft+QQ2A7e17+uWD723vZ1Qig/TGnrjpDZoU/dnbZKwUESB2QQ6BSoVZaDMOVYCgqB42W9tEHt6me0CBdeEhfKICUoevSK3DWxdeOLS7OvdBl+7XXn7nGoX4fGjX0I6hS2qqu1/ND5zPzkkdHJGaJY2yFSQ7REyKIID80ayP1SCNG+kMk12ZkCfYvXjXXkEhJGlfOtNsYq8makaLr5rk0dGtPbbCHa24TtRChKYNRt0HrMXFjd1WC7eoOuixd6zFg+yo0x17WhG39wzwYiJyTReCFR5xavJJOAi3j02pbWx/Hf5UHn5yF9arTJrQ9efiXx5qKTM4NieCExq00MVRJRcRkDdVa21eMFo6wVzXx8XYST6JDlsnD8eVF4hJfr5UMswOehC06HCSwJKBMfrNFmpZVjwlazUeXks2gvKZoTw66K+cGRyvnP+7UeWEwGLBSWYC5Has3uzu59IKwilzdViCW57g8xH+mD0ryjTw5a12ut2z1vhjq2UY8mmscX8WsGn+ZkMrDvo7clXhhmGon5Opx2OE3jncTlb3KVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(261022075727099003)(5023799004)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTdBbXFyM3pVYTZSNWZsWUpQMWdJM0RXZThCRG92NzdZc3VyQjdsUGVTZUhG?=
 =?utf-8?B?Q1hnbGhYd0ltcm1yRUpVaUxSSmRQOGZVR0JHbFJWc3NmRUtEeEZuSG9XL3M1?=
 =?utf-8?B?VUllMDRxd0RSZXFOMk9LbnluRjhIQ1U1Qk1PZFVxWktwd0F0TEQwZWpnK2lw?=
 =?utf-8?B?N0FwaUEzbU1NZ240dlpaVWZEaWQ4bVE1WlBIQzV2MEplMGlwYit4YlJSQjNk?=
 =?utf-8?B?dHJvMjA3VzNtQ3Y5SXlLUFZnVTMwUEpvQWlIN3l0dDUvME1zQ21YOGtZM285?=
 =?utf-8?B?UVczYTV4ZlVMa200L3hBSU8waElObW53c1BYTnNPcWdCZTV3di9BQjVxVUVl?=
 =?utf-8?B?ZjN2L2VkOXBaT3dtcVBLQmJWY2ppMDJxL3cwdmNSVTJ3VVAyTjJwZEloV2ov?=
 =?utf-8?B?Vllmb1UrSDFEeVo2WlZCOU9UWE5yU1dXR29hYU83MzJtTU5tcUJDTS9nek5W?=
 =?utf-8?B?Q2FzVTJxYkh5MnYvZmJtUXhObHFjcEhKRUJwSnQ2dGV2c3J5WDZnc2ZVN2Fk?=
 =?utf-8?B?K0QwYmhZT0theUJZS0Z4ZS91ck9tbklpVW5xUHZneDZjQkVMMlZ3Ync2d2JP?=
 =?utf-8?B?OU8yZThGQTUydE5vN3pHdUVQSDE5WXUzc1o4TFVHbFhkc3J2WFJxTC8xcXZs?=
 =?utf-8?B?aUNhZURDbjRKYWdFTUo2MDFiY3hLM2Iya1pMUWVEbmtFa3dTOGlWeWFaK2E5?=
 =?utf-8?B?NHRxZTduaWtwc0dDRW1JRWd5ZDI4ZU9zTkZaYnJGMlRRbGliSm1POGtpSGdi?=
 =?utf-8?B?VWtlU0thWVFlYXNEdm1PQW9hNWdNMW5sRTNLcE1ia0xaOXplVjd6ZzgyMmxt?=
 =?utf-8?B?ZUpnSkRHQTJPMk1PWjJOd2VwK3JLV01IRjBUbE5MMCtJbGRNUkVrUzFacHd4?=
 =?utf-8?B?RGxvSVhKTE5ncHhhd1hEYUpIMnpZRlJmcE5pWjQ2djZjOFJsVWU5OWVJVVV6?=
 =?utf-8?B?Vm8rL05XczZPS1pVMm02dWFPSjZjbFFyNGpBQUdpSHpTQ0dCUWVYaE9lVlNx?=
 =?utf-8?B?ZXB2M3NPQnd3bC90VEpLeUdXK1dCMG1QZCtTWEsrQjRXT3FMLzE5bzcvaHFM?=
 =?utf-8?B?YnFIa3RScXZaMWFhVllJVXpXOXNZZWhEUFo2RThwR0h6RG5NYU5VWXEvOUJt?=
 =?utf-8?B?NGVYKzBYZUtzQ3A3YUtjbGx6TU5iM1dQWGoxdEZmdERianJaSTd1MVFjRnlP?=
 =?utf-8?B?MEYwREFXTy80anZjKzFuR25KREwyb1NSRDJpekJNVDI5N1Y1WGdkMURNRllP?=
 =?utf-8?B?cGkyazlGcTNwd0ZTcUE1OEVzTzFiLzBhT0YxOVJyd2FLVmFmeWRYeElEeWJV?=
 =?utf-8?B?MVJNeWhUelVBdVdDZDVuVExubTA0ODRLMUhQc2NnckdXYWMrcnJCNjhCTVI5?=
 =?utf-8?B?VFh5Zlg4VlJHNnJVQXdaS0NhWXd5QTF1bGtpQXdpbkYzMEhhUHRva1p4U2hj?=
 =?utf-8?B?blZpeVlxVXlZYVlZZCtkRStZUXJOUEdKMGVxazFjOFkrb3N5a0FhcXlreHNo?=
 =?utf-8?B?eUYyUGJJSjBXK2h2OXRhbkE3cG9namR5U3Y1cTQ0M1BDb0pKK29uekFURmVG?=
 =?utf-8?B?YUhXUDNKWnpzQTc5S0FTam5IU3VPemlVN3BWZ3VENE9RanpXaW1aZzlsYUN3?=
 =?utf-8?B?a0xpNGM1WStUVkp3Z2huekZnVEVLQWJJN0V5R2pOaUFPSVM3OEs4K2lza1Rz?=
 =?utf-8?B?UnY2SEFJbDczVTFJN01XaEczN1RVamxuei9PUGVYZHUzbU1vOElyZ0xhZThT?=
 =?utf-8?B?RHpPSTkzMVhrWnZsZ3JQbFNGd0F0TEhWdTFrY0pOSWx6aE55Z3pTeXl4NHUy?=
 =?utf-8?B?cWtHaVUxaGZ6aGprd3ZGZy84ckdXVWVLVUZybEpLdGkvaU9xVGF2ODdYcU9C?=
 =?utf-8?B?T2M2Y2tFUGFXdlRDRnl6VFkyK1czaGJ3NXJ3Y1hmbXhZK3djSVEvTjJzRXo2?=
 =?utf-8?B?ZnVqdlI5WGZkNXpzZHdGdy9KbDBIR1BqSnNRSGNjenBQNkhxR0xsMUFpSTha?=
 =?utf-8?B?K0xHcEZ2cHRsNGkvVXdhaGRZVGg1Ly9XeGhXVUgyRHdhcS9pNWhTTm9oU1Q5?=
 =?utf-8?B?eHZ0UWNMeDFSQVRjRUZHYWhsbWhVcjhDcjlzR0d1alFpcmJOZUFJaDBrUlcy?=
 =?utf-8?B?b3QwNWxWRHRraHZtUGNCZGRNMDliWm5DdkZXNmd5ME10eUVuZGRJTkRYdGJa?=
 =?utf-8?B?M1g0K2R5RHZvdGFQc1BSQlpOb3JpSWNWTTJQVEFuV3BjVWdScy9rSllLQ3FW?=
 =?utf-8?B?SnhDQkJDbThVVlVKT3JhdlVNSzRhdmFyTkFNTU0ySGJPUzhrQTdzdTBTYkVI?=
 =?utf-8?B?ajF4eXdWdXJNSC9IWU1uSzhEMUQvSm5OZTZqQjVUblFnc1E2d0psSHoxWG1h?=
 =?utf-8?Q?0tnS5/Cpd82rjQN8Ea7rGvVjG1dazG7uxKiGV?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f7fb8a-38d7-48a6-7637-08df4579c100
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:42:14.2219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJCaoJPOn2GUErd7AEjeeWMGGVkE7mJUrbY6AjoiGPxC7gWFQCEVrTzPjcrEGhNlqwCmYUcbPUkTbTomBHuqGfx4x3LFQcLisKUBiNk6bZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8248

> Can gating replenish_dl_new_period() on dl_task_pi_blocked(p) still
> leave p->dl.deadline at 0 when a sleeping task participates in
> rt_mutex priority inheritance before waking up?

Yes, as on v6. Both cases are real, and upstream. But deadline 0 is one
case of a wider behaviour. A deadline task that sleeps keeps the
deadline of its last period. After a long sleep, that deadline is far in
the past. It sorts first at a requeue_pi, and it blocks the boost of a
sleeping owner, as 0 does. This happens with or without a class change.

This patch fixes the case where the task already waits on the rt_mutex
when it enters the class. Refreshing the deadline of a sleeping task in
the rt_mutex paths would be a separate change. The cover letter of the
next version lists this under "Not changed". This was checked again by
reading.

> What happens when sched_setattr() changes the policy of a task
> blocked on an rt_mutex that is already in dl_sched_class due to a PI
> boost?

The class does not change, so switched_to_dl() does not run. The waiter
keeps the deadline that the boost gave it. But a sleeping deadline task
starts its own period only at its wakeup. This is the same wider
behaviour as in the first point. At the deboost, the task starts a 
period of its own. Upstream left a deadline of 0 here.

> Conversely, when a blocked task leaves SCHED_DEADLINE
> (!dl_policy(policy)) while remaining boosted in dl_sched_class
> (dl_prio(newprio)), setting ENQUEUE_REPLENISH in
> __setscheduler_dl_pi() has no effect while !scope->queued because
> dl_boost_blocked() is not called.

dl_boost_blocked() would do nothing there. It only acts for a task with
no parameters of its own. A task that leaves the class keeps its
parameters and its deadline until its 0-lag time. A queued task boosted
back does the same. The new donor still reaches the next owner: pi_se
changed, so the chain walk goes on.

Both points were checked by reading.

Apart from these points, the next version changes this patch. A blocked
task starts a new period only when its donor changes. The reply on patch
9 says why.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
