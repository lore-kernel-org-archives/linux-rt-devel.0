Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905880;
	b=JL8kNNelnI97PkUSfP8lvgIq3bx6VL3keIDxUtBErZtSrGigIwSVy3s64nbztY+ZKvj/
	 AAWhng+duZxU9IZ4msljzB8wyKm106GPnpTKj3mfD5rTzsPYLOz/S5pmBl8MOYIvvRrbP
	 eKk3iWhElsGDTsB5FO/wiN5jFwcqEr1iXE743FNPZloI4H9sbDYY+R+8rcXRC549ZVxc4
	 vAKfVd/7YT8S23HVDT67pH00C4D/s69eVMGa84YSKJlWYxjHpWtB9xV2cedUa8sM7SRoV
	 gcwQjHGM4WORpHgZgZYsWWYCsQ5OvhgKoKSCZrikEqz5u37sNeYeD6XYC2jHwpW/NBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905880;
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
	bh=3VJrZIttE8Vn3A7x+kqkm3j9AXtK1xApaBB7f69sx1c=;
	b=YUtxQbE5LuFcDT/D6PC4s/8zRMRGnV2UOBKDfPPm7GT/dHstpayiTErp9cMqz2f9fraQ
	 ETXzY3Pkx7kHaSz3fmLwxyffxb0gx1ylv++3EEeCeZ5TJTffMkLXLa9R5IkDlaQH1iUhz
	 enkyfnYr7L7bxQ9E+YaG36Svvgh0BFtjm/5mzahcWjHn49WaGLQwdCvnzAmiU9medeJ+D
	 ++xQy5ZHnC+SVUE+geM8nbm7dRbnzRcHC4I0QNptLiToNZ4WDytRFv4r51iJWR+aKYJZt
	 DrT7FlxsdxYFjaYvO9z/aA9rhzruMtjO/uy76AoC3DoWljar0xgFgjRt0XZviFhsEyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=J2CwjffH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.101
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022101.outbound.protection.outlook.com [40.107.193.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB49606A33A;
	Thu,  5 Nov 2026 19:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB49606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=J2CwjffH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/RK6iygU5yiiMI2upridyfCHz3+eYF6zbq4pWx1NiTozy8o3efjewqxQJ91I77eg0oSaIGEDMiNvmHvAIqbd0VPCQn2dBb7Qwd/HbufHkUIeZXXohVdLkdw9F55IZ8vW9+LxA8X0gZAMJxm0+9zfYTrK+JmuiLZjhgmnzugQhufvFyJ8vTOybCXQjoQ41fPaLyhvANyAo3lxxkkQU4XTAMfg6Mtgwhe15tzQY/YXuAQ2NmjhGoPtCCOsF+OxXEQgVoOhIaC2ITBYm/G7hnTi8T4O4Jpa/TQZf22Ub0PiOKpcH/QSoZPYK/+ww9Y9YSfDnMEMTbroeoW7QnpDxtO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VJrZIttE8Vn3A7x+kqkm3j9AXtK1xApaBB7f69sx1c=;
 b=t99H/L6Pt+Z6qdfx8xl2zX0p1Kg/vfZfyPE3+Nt2iPS4hiXR9ltvznm/KuK6gPXH8s9GgO0isyoQWIqOqhhtM+EIE4tx6TXHHlCxKD23BsphIsyIFx1CwLYuHNVQSrwHJjGAIOf/YHqFjqy+YG8bp7fSYxNG5cQVZ176kRMUxzlbXJbLOWwaeSdNmkPuCTqlrnDOOMZjByxrugAqO1FthNYu28juhl/20HbKl8zgfgl/hr9n6EkW7qwpBWDb9OQU4OKZlyBJqupHytviZPD7x3SoPRbBDoJwFdSvm+n3DTslj2+W7xUG2/FcTPbyPyVBrj09rwPoYStyPgjCf6ydnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VJrZIttE8Vn3A7x+kqkm3j9AXtK1xApaBB7f69sx1c=;
 b=J2CwjffHkCYNMT3RL2XaYfKe6CqpumaRSFFG1QQSpYpfXJpcVrnLK3o3+8MBFwF9zEeEHE6bmL6gBF4sNJZP5dC7Oz40g2T7MCgT6Lt0oQk220+l2IKuKbgENJEnzQPCAVXq2FsvYzI0HhTRCv/qnoJsbBxZ6ElEo49+FDGYw/sox1kSES+3nx88zLgUJXcGja94HhF9a3FJ2j5mDlaO2+0cRbzRvoHcvHWf9aoEgg1P4RmZpqL1nSRKq3bpRAqq5SV/GyVuB+E9WGym8US9RSGm0pM2TMrjev2ESaB++rZYD5pd1wDnJ6/hN1h/lDU8tY2/wUlXiBjD7VxA6JazZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB179232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:113::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 19:11:19 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 19:11:19 +0000
Message-ID: <49685618-a72a-41e6-a191-f30b61b2afe8@efficios.com>
Date: Thu, 5 Nov 2026 14:11:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] sched/deadline: Keep departing bandwidth across
 a root domain rebuild
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-10-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-198243@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-198243@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::25) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB179232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9dd623-4cb6-443f-844f-08df3b709263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|5023799004|4143699003|56012099006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JnNg047x0vRxLJDvNf/jgmpKThuB2h8syyPCCenXHIEP7udssQG9IDJIMcYNuPPdZzChimWED/zkj8wpzfO63DV7UIuNLMM6k6O46PDqDnFy5po/3SBfspWmiQd+G4SCUibt53zVJDzLlYpoI7/A3Aqrw3dZXZc30CJn02PcJVO3jur3fwCMWy65CLQ8rre5K7563EX+njNTcRMj5GWl6hiaRhSdSj1L9Nt89lEIxVW8hqDiuBRLnr5i+tODQ6ViZkEGA539Rp5dNrIhGPD5+l4jbe+kHo8PLqHviWEAc6y8G0bhfbfHHcWvRbgBkt6gaBWM3JimQpzEW1rAU6pTgXqUBmlg2YF7xJOtxe+m76iOg7/ZtZmJKe5gP6ubRw4wcu/H4i5GLFJiKWaH0Tyk3LmOKmajtWc5T9S8Cpt1yw4fQmoloi9nuT4w3D+jFT14fxQEF12XKMNHyAyjOjav/1Vb3eI9xjwRRNVYnnLAQWQ/cvmdk62xbV5G6jiSKR2Gr1BU40/gnzPg1Jp1yYVvh2R7VzygRidxsK5zJ/HIYi0njeZO2wO9bsgLnADMkyABQtyvv185dcZ0SrpwLUl8fzqI8csH6b3wPJVAm5aOGxc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(5023799004)(4143699003)(56012099006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amwvMXM2WmpySmJBbTFmQWhUaWVnWDZrNGQ2L0lCaW1IT0p5Q1J5c283OU1H?=
 =?utf-8?B?cnZMNVExYU9NeGM2V05ZTjVyd2tjYUd2ZUJneUhacTYyaUxhZmlRamFuRmNa?=
 =?utf-8?B?cnVNNGlBUjQxZXI2TTMzK1dIQTlrKytKc0pvb3h0MWJKeURRZEd1TktRUmhy?=
 =?utf-8?B?WHYvR0xFMWVhdmwxQnFwNDJIckxUUm1QTXRUUEdtNTNIb0NUUTd4bEpmWGtD?=
 =?utf-8?B?V2lsb1dib0JxTDB4dlBEeVpwNWtUWDk0eDdFRmZqT1ZaRFhBclp4dDFFcEtQ?=
 =?utf-8?B?K2xoY0JuekhEbVcvQ1UybHdBY1hYbkp5amNvRFZ1dFRvTk9Vam9ML1pGVGlL?=
 =?utf-8?B?VzJYUnpXaEtROUZHeDRJc01sUmI4ZGN1YUJBNG5pclgva08yOHhHa2w1NnZv?=
 =?utf-8?B?MUlING9HemlPb0dRRkNtWEJzQUhWYmwybHlneHgwUXVDenptZnNEcFlZQVQ5?=
 =?utf-8?B?Qk00LytQOUptejZ5S2xscnBZTHZkeWpxQkMvajNqOXVFc1huL1k4cTdXTGg5?=
 =?utf-8?B?UUNmb2FYN3dpdjhaOElYRWxnU3BsakFhcmlPdGdJZGlmdVU1MUFZUFFIYWY3?=
 =?utf-8?B?aWZRdVorSUpqRjU1aDRMdExUYms2Tis5WExEWE5FQUUvMkxYVmtkeWpnWG80?=
 =?utf-8?B?ZU51SFVYK0RYaTRyclhoTmdtVk5BVk9qZXdSVGsxVm8xMFdDakFCWG5VUTYv?=
 =?utf-8?B?eTZ6Y3FhRFFPdVd3dHAwcWUzUzQ0RzErcmZaY2h6c3ZKSEdZWGNlKzZ1S211?=
 =?utf-8?B?NXE4VUJnSW1ONXFTRkowRHNId1JQVWZpYTFHQ2xySGM4RkV2dXJXdTZWTjJS?=
 =?utf-8?B?RGRDWVNKeFVrTjg3TGxPc3A0Y0swdXU1VlZobWRHN2t5UjVwekR0Q0RZTWho?=
 =?utf-8?B?a3Vtd2FDU0c4UDV4UmxhQVpmd2t3VWZSNThtSjVKL2FtT2d5dEh2SG1SNVpz?=
 =?utf-8?B?cVAweE5TWkEyYTNKeWJtb2NWMDEzOFZ3YmdXRVo4cEdTZnBFaDczYzRqSW5w?=
 =?utf-8?B?bG8vRmJ0N1ZDZWJGQk9EeXEvLzVzdGpLL0w3S1lFYS9HUml1STBvMWVpTzFr?=
 =?utf-8?B?aFp6NkcyUGJBREpqWVEyeGFqWXpqUWx4dFlnUlJVOHJwK2lPMDF6enQ1ZE5q?=
 =?utf-8?B?YkY2V1hJR1orMHdvLy84cXRGTFg2aDhTVWc3NWdiS3NndU9EZGdHUmE5dGNT?=
 =?utf-8?B?eDN6ZTdqUW5TSDBMOE85dHhGamxrUnhubGtMVHFRN0d5Vktqdnp4RUswWmww?=
 =?utf-8?B?WTlMUVRQMGE0dFRieWpuaExnNHdOSXpHMHpocG96L25uRkZnTWZvd080TklY?=
 =?utf-8?B?SGlaUUorYkpGcVFNNXNWUzhlTnNCWjJEYWoxd3BMY0xWLzNROFZHUTVYOGVq?=
 =?utf-8?B?YWhRcDlSTU1hUEhnaDFJMWxFdnpMaTRDeEltL0pYckg2bmpWZDRhTUZoRGQ3?=
 =?utf-8?B?VFJCejgxQm01dHgxUVdqRmxmdkJVNk9QTWhPaHlIQnd5R056M0RCYVdHMUFX?=
 =?utf-8?B?U0M4R3RlUEx6TFpvM0VPenJlSldmWFVaNWszKytTclNSUEJlWC9UMWxHZE5J?=
 =?utf-8?B?QmxtcUUxaUw0a0pLZ0U5REd0dGszZStSaXFuaWFJaGhmMTU4bFQvYTdRbGV1?=
 =?utf-8?B?Ym1SK3J1WFQ0QTZFUCtxaXpSRG16bE9tMTRRRktyM2pnL2pVcTQ0NkVlRjFQ?=
 =?utf-8?B?TGdtQktqVEJ6Ull4ZkkyR0RieTM5OVVTTWZRT0RqU2JFelI5LzROckh6dUpB?=
 =?utf-8?B?RDBSZVl1M2R5MGp0djRPT0pBcFZSY29NdW9jRVdmZkpJUzgrRUJjcDU1MmI2?=
 =?utf-8?B?dFNZdEhVM0FLSXB4eDlCTVZQeHc0ZlA1bzdQaC9CS3dnSVYvandHSFhpNE9o?=
 =?utf-8?B?QmVqMFhCZE9NVGg3TWVFb2Y1RVorRHNORlNtOGhVYjlNNnF0Q1p4WWNBSlNt?=
 =?utf-8?B?aGZUam1uV0JmMEpqbDMyNzN5dGxzV0tCZFdRcXl4a2luZDd5RHUwWi8xbUVk?=
 =?utf-8?B?UUlUdm96Q3kwL0Nic3d5OGp3dEdxaFRqWmhIRmcwbDlZVUFldUhQU3h1c0Iz?=
 =?utf-8?B?VTF4Y3AvY0Q3OHZKc0Q1UEIwOHRjR1daL0RZdVczWFNxK2tmQnpha2dkd1A1?=
 =?utf-8?B?ZnkvbTBTTDVwRVdDUm1KY0RPQnJOUzloVU5ISjd6cW5kN2xZUjN3cmtaZzN6?=
 =?utf-8?B?MlZHb2tURmNUYlRrU3dUY2tQNkhRYVRRdmlucXBvVlpCVFovRzJZckkraVNZ?=
 =?utf-8?B?dStYMkpiSDR0M0FxVzZ4TGtZaUI2Yi9rUTJRZTM1NGdwNURiTjRnRVRJaFEv?=
 =?utf-8?B?bENXdXJhSjBVelBmbVEvRVRGdEZTQVFmTllwc0ZaRE1TcWpXandsa0EyUERC?=
 =?utf-8?Q?fNElXuLcCH0OTfm4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9dd623-4cb6-443f-844f-08df3b709263
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 19:11:18.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMPglk9vtcrY2tb/ZNhb14IYr0nndyEBiCiInyQqFB13bmcfF2pAGjGqcMsj34g5lvphmUYYzC1EdMABDqUy3Q0uoDcKcy5R+HraCYvrtTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB179232

On 2026-11-04 17:44, sashiko-bot@kernel.org wrote:
[...]
> 
> [Severity: High]
> As reported by Sashiko on v1 [1], can priority-inheritance boosting of a
> departed task before its 0-lag time corrupt root-domain total_bw accounting?

A departed task boosted into the class before its 0-lag time is counted
once, wherever a rebuild runs: the walk finds it in the class and counts
it in its cpuset's root domain, the record is updated, and the release at
the deboost reads the record. Where the deboost races the walk, the
departing bandwidth is dropped for the remaining lag, as it is for a
departed task whose recorded CPU went inactive; the generation keeps the
release out, so nothing underflows. The release before the 0-lag time of
a task boosted and deboosted while asleep, after leaving the class, is
early by at most the lag, where the baseline leaked it for good.

A rebuild that finds a CPU for a task an earlier one dropped counts it again,
which is the intent: the bandwidth of a departed task is held until its 0-lag
time.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
