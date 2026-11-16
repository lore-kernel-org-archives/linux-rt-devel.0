Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794840054;
	b=VE0AP9eF68Cox1jOjheCO2NRS4jOxMqbgCZ+Q3aFgyIWQ9qAAQ+NOmsgeSXz111jOU1K
	 3RFZAPjLPFASwAzC9LntWGFvKBgJmUQN9eNAdyB2ZmziLwyiYs9kJK2hia/U7jkbVV1pl
	 DNcnBdQSQOT96X/cKSkFHMn2JylsIpKGq0D9WHalBT3qjhUAyvIeVNivXpvTujEUqoTQO
	 fWJ/i2A9yJxgrUTD0WvyAGBGfl59L+jD21caj0lK3AO4lc1nVJJ5kIv01nVoCtC5Vta9K
	 j3vC1MGcMpfmEuYRWL6897YL8aMxFjVLcA4kAS09771I57xnfwEODx0a1lJ1B8vlBSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840054;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VqfbOwrlNXH7MBy2kO3Dzp0ect/wJh9Zs0CWKeehpek=;
	b=YzhR8Kozcgw4FBHsRKdxaW5VV53Qe7hFrwfCoMAA6TbcdEsK6kz15H6Vt7Fg1izD6UGB
	 RHpjYKGnBjrBeTOQ1Cweyxr6ed/1SjsdJVNFkHkqLtPj4sOXIyU0QOTcIC0pT/wXBA0Gm
	 u7Kn45K+v3Dx7yI5/CJnbOgLfHofOkZVDq/4/UomE7MRp4EZUcKiu6cGdCXhzI2Lm/bOc
	 z13voYxxvLwb9e+oOgwxRq9QGLffwfemJGsOGV/PqXXL0cZuAN6bU48Oc5wZv8pqTobfK
	 VF7HIxPH6yxH3YgFPbNASyi1rIAWAuihpfTlxOdOXcQCv15psNrkQ6BFKUbrdYDwvsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.121
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021121.outbound.protection.outlook.com [52.101.100.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC8606A323
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 14:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCDC8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft/dWdNaSiMMZeKCbBWmGb9KFvkClp7eEVM6sIQnei5Fexkau1B4tMjhUmYow5qwu96vxyIL46IFjNlACdnF1yX62RGE3A+ntFC+AEmC8VH7c8Ehls0pb9rB96dCFp/wzwMAIGrjabeioNKDGubxfkJsZh6IL3za5EpjujVuZ2CSsdoctO6fyFJUMxXzIS87ht/pDWR1C+i3kgJW2PirJnQk+jpVBdelS9eCtUvBFvMYivqYJ1Rjl1Nk8G5FkCWnqS1QSuzGZtwy0GpQjtJ+Fi6OFimpmv6Wdul2QG8xdNSFvUViigU2ZhYit3OrJm065QX9dIDF1XHUdur0Unlp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=VqfbOwrlNXH7MBy2kO3Dzp0ect/wJh9Zs0CWKeehpek=;
 b=u8vpHq7qVWoCnB8tBnmcnGiFRPu/QJneohVhRD2UL1usyEUq7MTGynBmHHS0xW2VyKlAaXepldW3Iu/6c06lZkqstgJjvoeQ01O3gRc9nMlBLTH3ACTI9+BQ64SA64LR2wS7lPgAVWRn1vEDvQuq27ddwfN1vGTEG4qWPriE3vc44AJRoIWx2fEfRYYdO2WiyOF+QeZi6yvCnU/R9HOazMIsPKg1nM2NWVgUiKGJxmiHG25hokgDkHPfPW2mVIqFdWJLM0x7RQlfU+W41xKBUUeLGGDBvR98cG8CEvQcaYjQuCW3kVsvgvDb23I96JFOZqJR+gqmF2tF6sV34Xut8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO4P123MB6596.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:278::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:40:48 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:40:47 +0000
Date: Mon, 16 Nov 2026 09:40:43 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: pmladek@suse.com, john.ogness@linutronix.de, rostedt@goodmis.org, 
	senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, 
	baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, 
	anna-maria@linutronix.de, frederic@kernel.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/5] timers: Avoid blocking on hrtimer_cpu_base
 lock during Oops or panic
Message-ID: <cg4idz5t5eh4yptrte5xvyhpk4jrp7ckch3iezeto2enkai7id@jqv4w5gkpagu>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-4-atomlin@atomlin.com>
 <87y0b1tzbi.ffs@fw13>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0b1tzbi.ffs@fw13>
X-ClientProxiedBy: YQBPR0101CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::26) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO4P123MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d329549-b645-4dac-effa-08df43ef9a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|5023799004|4143699003|56012099006|261021135927099003|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	AHJueKg3zlZXsei1W/PzCTxRFm0PfcX5K+p3amgfJ/Qnv26F9C3ehWIVwVmZFaujFEaI2AayiZh/k0WLXP3D0UgqCqcTrYs1LqzXTTgTmZJ7Z+7d4YD/ij0V+s+JU7x0mR8n0A/KjubvvomJgGEABZ2u5S2x3rxqpNs/AFzfkiDpuSs///2bk/6zCtgSOiSkVXmqlLm0g0LHOR9mvWfI6ArTM8JKIa8W/1KL0uYCqpyMLPt03akeGzQqjAPpFbdG/rCjzEFM3e0+Y7OQ04fTqVaWPigkrs7326Bwu2a6xVu6Pyff+bLzNuBzgNArGXigHlrcng6za0ZDREj0SdnKljV3lRfQN0/HfoaEvS1x2LRf5Z6jlseE0wkxeWgGkTYQc7I+mrHTPxt39WskEpIUTUYITucTcOvBoxGmcH7zhP8Fn/YiiWWhAh7+gIH89+mMv2gz9OYLgSubQ9DKBViBjvUMvJgS6VATFUmqswvU5JuXeLaLTMZ/NBKhYjC1YfTBstsHwYHM94S4wJbLK38u7pNG4uI5U1BnA/cfbN/zKZRgEnfErMHj2L4ty4fIpPw9PGg3sB25q5ylBlKzJD4Iwn9dK0jMPNBvTWov1+9ecW59rNpvxt8ukpcafg7oQcxIBStUYkCO1Wf1QuybUCodmok+oxP63t4veMr1aHwPnRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(5023799004)(4143699003)(56012099006)(261021135927099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjlWcmlNN3ZVb2dQOFhMU3ZnYmtualhaNUt4eDIzbGw0MUN6N0pPYTB2Y0Y2?=
 =?utf-8?B?REtoR0xSWjF1eTJKN3VhdXFXRGlWZEFaSlpYdWtLeTdWTHo4bzE5ejJXR3NW?=
 =?utf-8?B?cS8rWGZIMXFnaU1WOHJrU2ZGZDlxaTR6dG5rZ3J3eUhuTnMrOFZEbFk0TkxH?=
 =?utf-8?B?RDUyeFJobWhNTWdRbHp1RGw2UWdURTlFcmliN2VZK2EvMXZ2aVIzSGdHRWNX?=
 =?utf-8?B?bEhQcFkrWllZd2k1Sy9WRWhQQlF4dGFvSy9PazVrRzRRMGhkSDdNTkJyWEVL?=
 =?utf-8?B?VDR0a1JvQXZVbFZvOTJGaVhmdVNSQkFHMGxzanM2V3Z3Nk5KaEMxVFVOSkRX?=
 =?utf-8?B?WGdPOERkL1VmQS9VajFJcEtxVkJ0enkyKzNTdm1neS9mejNwY3ZZTzZkL3lP?=
 =?utf-8?B?bFpGWHBtWjBTZE5NbUtTdGlQYzJyZGN5MU9UakFaSy90cmpXVkdKaTdZVGE5?=
 =?utf-8?B?dUNFb2dPK2t6eXJwTFdqVWpNOXdFWE1qQloySlhOS3ZGa0g1eXVIZXB1NDFl?=
 =?utf-8?B?ZmlPeURCWWxPL0hsNzVVY1FGN3FFa21CQTJsTklZN0hIWkZWVEVUaFNsSmZW?=
 =?utf-8?B?b2RDSndTYUg5YTRMT01zalQrbmRMTHlNbmdhZFp6WG5Wd2Z6NWRnT0RwaU1G?=
 =?utf-8?B?dktzVUNoM3dteFRxRWcrV3RZRFNhS0NZdHowMk1XN2ZadnA2T2x6aUcwSWJN?=
 =?utf-8?B?dlV1ZmNGZnFhWG9VekdzN1p1TWZkS2xvL2xKcTI1a01tSm1YcllWWEg3M0p3?=
 =?utf-8?B?a1VGYVU1TzRHZ0FEYnJFWnFEMU9EL0tTZXpLbittMHJERmZNWEg1TDNuUmY2?=
 =?utf-8?B?WVpLOTE1OStOTUUzZlgxMk0wMU5STWcvL1QwN1ZUZEhNVytqOHdyL0tMa2Qx?=
 =?utf-8?B?VEdxMVU1VmUxTEFyVmFBNk1XL3dDbnR5SCsybmhOSDZ0YU5RcDN1WmRnSFlR?=
 =?utf-8?B?WVYycytEZDQ4VW9OaFBEQjJNWHREd2pyTURZZWtTWlR1S0pjRkpHa0IwT05P?=
 =?utf-8?B?QTBBSERYQUhDQWlHbDhwSmZ2NllLN05YVldKMmlUMlVvdktkTVRySWZjTjB5?=
 =?utf-8?B?MnprUkNyV0J4aEhkWDdUK0pDSDdtendiQVhkZXQweGdvaVdQdndjekVXR1R6?=
 =?utf-8?B?MUloTTdCbFVwVDBhTEU1VFFrYlA5UUFIM3MwbklTYk5icjJMNW9maEFNbFMz?=
 =?utf-8?B?YTFFZDJyYkJGTU42a3l0WUl3U0Z2bzAxTUo2bHlpSVZ3elQ4bjBqalUvUnEv?=
 =?utf-8?B?ZDVDaUVWeUh6Q1BXem5lTEtxazZKOXhaMStNUnEwUVdITEJHV3NMVE0yb3BL?=
 =?utf-8?B?eXd2MHlLL1FhVzhaOEdpWFg4NlIzSmVVMXdZcUIrZHhiZERpY0RhbUtXY2p5?=
 =?utf-8?B?Z0ZlMS91NGY3Smc0NWc3Y1lHSnpOT2dNMkNGbmhEZ1czeUpyOHZzOTNSZytu?=
 =?utf-8?B?Nkk4dnpzRkJWS2I2emIzcFh0WWhib0drcC9ST01ESVc4VGh6L200aE00MHU5?=
 =?utf-8?B?a2JObUhtNERQby85TDNsaHFzdnJ5dzkzSzlBMUc1T1RPSnN6NjYzUzY4dHpW?=
 =?utf-8?B?eUl3aG1mTzc4dVNCUTlLeGozTUdDTk5TbTdlVklLWUtueW1ITExtY1RaclJj?=
 =?utf-8?B?bW53ZU1iMVE5Sm9zYU1XdVNMTFpUNW9lUHA0bHZPV09wRTZYbS9VV25QSmVn?=
 =?utf-8?B?WXpnYTR0Tmd4S2JuNjdTYURPWXRTZFJoWGwrYTZlVmp1bnRoZWwvMkl1dG15?=
 =?utf-8?B?b25WeDlBMWlBd3VpYm91bXIwTFQ3NHdnU1lBR3kyQnVXWDRia3J2amVnYXJW?=
 =?utf-8?B?VGJqL2JYUUVZUnJNaTcreFE5dERLbW83djNVMzFqWUR4YUtSN1NRYVQ2cEdO?=
 =?utf-8?B?WHBjVTE3NXF5dEhZZmZCZ0hZaTFyZ2tXYWZmUG5kdWUyV0ppeVNxdDYxejI3?=
 =?utf-8?B?aFVTTTVFSGpNT1lqMHVYZloxM2NudEZPMlZQSjlCQThFLzVkRkZLWk1hQ2c3?=
 =?utf-8?B?d29BOUVRTUV4ZDcwSlFHVGxnRTJvSDFJOVpWOFVKQzE5SjhibkNPbTl6REtq?=
 =?utf-8?B?VlNWQjUwQnQwUEw3Y29VVFNpdlZKdmY2WGJrNlF0TGhsdllrZjlYWkR1bHdT?=
 =?utf-8?B?Z1hPYkwvMnd5NmgyZzk0aXBXSWNpZ3oxZ0NaWFRiNnhmTTVTbjh2eG15M0JS?=
 =?utf-8?B?N2dONHZlUk9HblBpWDdLbEI4WUhwcTFyY2c1Nis5bnRwSTRxaE85WCt6RVZp?=
 =?utf-8?B?dkR1M2dCa1F6Umg3RUpkT3I0OGdSdlEvS1hGNkhQUjFaa2E5dFhZOXlzWHpW?=
 =?utf-8?B?OVBzbGFZbytscmpJZXY0T2RCbTFjUUJkOW53SG9WL1ZrYnYxQTRjdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d329549-b645-4dac-effa-08df43ef9a1e
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:40:47.5868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfPoetjicRaqC1hoj+RXU49LhpVUf9IWxS+hjajxJvUASfTQF41x7JWV5syIx+GaA8VocSMyXulpcyo3Sq7hUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6596

On Mon, Nov 09, 2026 at 11:28:01PM +0100, Thomas Gleixner wrote:
> > +++ b/kernel/time/timer_list.c
> > @@ -68,7 +68,15 @@ static void print_active_timers(struct seq_file *m, struct hrtimer_clock_base *b
> >  
> >  	touch_nmi_watchdog();
> >  
> > -	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
> > +	if (in_nmi() || oops_in_progress || panic_in_progress()) {
> > +		if ((!IS_ENABLED(CONFIG_SMP) && in_nmi()) ||
> > +		    !raw_spin_trylock_irqsave(&base->cpu_base->lock, flags)) {
> > +			SEQ_printf(m, "  [cpu_base lock contended]\n");
> > +			return;
> > +		}
> > +	} else {
> > +		raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
> > +	}
> 
> TBH, that's horrible and unreadable gunk.
> 
> Clearly the approach of all of this is:
> 
>    1) Pick some existing code
>    2) Invoke it
>    3) Hope that it works
>    4) If not add bandaids to make it "work"
> 
> Seriously?
> 
> Each of the callers of sys_info() knows the exact context in which it is
> invoked, right?
> 
> So the obvious and clean solution is to hand exactly that context
> information into sys_info() and further down into the invoked
> functions so they can make informed decisions and eventually omit
> pointless information which is otherwise emitted in proc/sysrq-t.
> 
> Something like the uncompiled mockup below should give you an idea.

Hi Thomas,

Fair point. Probing global state ad hoc inside individual helpers is much
uglier than passing the caller's execution context explicitly. There are
only a handful of sys_info() call sites in the tree, each of which already
knows its exact context.

For the next iteration, I will introduce enum sysinfo_context, plumb it
through sys_info() down to the consumers, and refactor
kernel/time/timer_list.c around struct tlctx and lock_hrtimer_base() along
the lines of your mockup.

Kind regards,
-- 
Aaron Tomlin
