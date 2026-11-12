Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794485489;
	b=kKK6ExTg9IgXj+MdvA8iI6Ri3hXLBGhPhKE43Hmx2Z3kBmO+QM4y+H9kDBXhpKLX4KY8
	 8JQU5C953TbIHhe1hA8tq9NzygzLMBk9bGRl80ttr8wmgxqxBlaVAfu5fDPL1D/1GS6Jn
	 i+I2WBwReYg6elxDB/qS9hiTRmEQxsoJ/v1/lyUzKux1KPzW9T/V/9fGNvQVpOjOm+tNT
	 P+R59itFFHO55TWOxpjvMoOMQ3JvFCKtVAd8PkplVfwT7R/ghoDXBYHrjtsfP0Goay82E
	 KBonAJXeTW1wuLzb3KyBW4/BJf/IkcSXRrbhlrSIwXrAlM6cKk6Huq5TcoFi597BtEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485489;
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
	bh=2igb4EzMhU9HjB1uGybM9GfGOzG5O0Se8+upB6lvHqo=;
	b=2fw7B8QgVy/llrMMy/XRrp41NbZ2Ml/jjUchwSo/nFSfNq5sKNe2s6icGlt1uxCrnURg
	 MmstV1LPYQ6TxtzXKVudo4UTD7PIc+vjFtmnrPN5PDHZWenxp0wVkd0Dc/De9S0g3jdzr
	 XFoV7IlUJSyXEiP9IeDIWjTIHEWGRnudnlMaaohMmZqGZCsows0+W5CoyaXFxLVs0KW5M
	 lEQj9MxDa2MVVxX4Ib8TEYVaCLYGDDQvg68ItaktC/9419c/gZxWaYzH97K639Sc2NraP
	 hscGYQPgQlDv0nHsKNssUno9hy7meu8HpAIg5XmtEnGwmFKRLzSL1+NmDa0MWuQNnrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	dkim=pass header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=pXtYHRmG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.9
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216A606A31C
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 12:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B216A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mobileye.com header.i=@mobileye.com header.a=rsa-sha256 header.s=selector1 header.b=pXtYHRmG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rScV0bv27a5l2+2EmfriId5b/2Hqz7W5qesj2PbhjhlbmFwuG+TjkcMKHtZDeOZ2UIJq4Az9AHnPkIneRPTBOfaTARKRNkKOs+jNG9N8jXA04+w5neHsLKQXRDyFhrbKGuW3IyS7rqfq9svN4cgxa2/mr1AC169FXkW2LxWuozbf6tAIc7zy2DialQIa32GU4AX3Nuqg1TlCUVI+gNcP00OMcYq0XkZn5BfMvEQMN0fXvDgO+ZGNIi4YKowpOeGpOsNhpdHCMzhAJWV0wrFj+vcdl1PeplFvbViQkjJjH+nZo4U6KURUoaXW2gYdPeTi/IxC/wblyUiyREBrszwEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2igb4EzMhU9HjB1uGybM9GfGOzG5O0Se8+upB6lvHqo=;
 b=cvgs8rRBB5f4OtwUgNW4868VDt2wLQoAFYgGdRXWQfJnFgErbAK7RJaiOXADzPAR52h8Vbvf3QkGRRFx/irizcJluhBT3Ste9/CFjBcTT3HLsA4JWRO+IyW/2VvZXLy80pAAbMJZU6EZe6Oz/4wPlkWsfaukYKTle9vTKnN22wtnsmmE/A9gPBgjBLrNR0N55QYzqQ4J7zSqR0+cpZQT183xYp2D6UYLTmbP8eBSgeSeWiC5ELkLAMLqJtwZO9WjlkL4Tps91A9j4VKzpWkdw24I0tqrRBwhz29VFZa1M84T7/r3iZ/Ya3eQWpqZYva/W3CHX74dmBOqbEJcFj1slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2igb4EzMhU9HjB1uGybM9GfGOzG5O0Se8+upB6lvHqo=;
 b=pXtYHRmG5D0SuyD6U1YR4jaP65M+Ycg+8LLJYuIhGRoUcNK/p6qsiOoDHXK27kkncDdY7O8swu9HOWx/RZbtt6ihUCChP7gi3Hnk+c0xUfG8FxI6Qe3BDqao8oOvZl7hNpbX1SxDj/DvMOIUM4W6KnlQmuPvPxT6JfaGXLZr/ws=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22) by GV4PR09MB191401.eurprd09.prod.outlook.com
 (2603:10a6:150:406::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 12:11:20 +0000
Received: from ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2]) by ZR6PR09MB889505.eurprd09.prod.outlook.com
 ([fe80::9006:1164:b51f:23a2%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 12:11:20 +0000
Message-ID: <a35f6eb0-ed5c-4ba4-85d0-c3a6d6bbe8ac@mobileye.com>
Date: Thu, 12 Nov 2026 14:11:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] irqchip/riscv-aplic: force synchronous probing
To: Anup Patel <anup@brainfault.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Jessica Liu <liu.xuemei1@zte.com.cn>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20261020-aplic-async-probe-v5-0-c4861c2aafca@mobileye.com>
 <20261020-aplic-async-probe-v5-2-c4861c2aafca@mobileye.com>
 <CAAhSdy2kxydOk9wPdBtVHCTN2uDrpFbQ0WGUXHz0AUvUWAncpg@mail.gmail.com>
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
In-Reply-To: <CAAhSdy2kxydOk9wPdBtVHCTN2uDrpFbQ0WGUXHz0AUvUWAncpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To ZR6PR09MB889505.eurprd09.prod.outlook.com
 (2603:10a6:910:e0::22)
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
X-MS-TrafficTypeDiagnostic: ZR6PR09MB889505:EE_|GV4PR09MB191401:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a2d3d2-b203-477c-a9a9-08df40b60fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|261009223027099003|18002099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	oxUK1Z9YZclUjTQLudvCH4BToRttWpSKtBbntBfM/FkqFyo1IuIlGa7ozzie0SXsVhS7qO90M7Xj1LdeDnIbzBLadZEuGdhNLXc0Awe0d/h+LU4Kr2s6vOxATqRClmjlK9dMaIhhS9QqerNCXFqQIODktnHIVUSsZUShLlmEgh0u9TYx7LMlmz6DGaUGj8uVJcCJxyn8rfncqHoDJd8/6W+lGIOR7sNkT2Ps/lQgGHGdPYRsfKPxtSPCPiRtR/i1D4XomvbVTWVcO/wruszI9cvJ1wAHMr8/LEPzaMPLRrqOQ9ql/bJF6iZRMjuc7L5fzhzIWY+FTPWnWLqA2PbN+iJKoPNnI/u1SA8g17zgJ5zaRaeQbTUsWPj+BPyOTkpopLgGEUtpgGVguSE8lLZtLlYEWZKN3IIo1Y6jGFSa74Ym5fOswDQWCCLTYpJzVksTGaidTa6db5fnZgfW2Vpu8+SKVl+aciJvGRcuwhxrbYbrgCEvWNgX49D2DO8cRYTegzF4dGKPw/XLzO6QMJdlDVwsMg52W3blI1jbWs55fFxJMnfOqQWAOxfuN9zg+d3bqOILtM+h5uy//azGjSec5VEpxxE9VTlQTXtmc7Fon+T4UnT7EWStjge0KhNaMITqTInO1bcqAkbIRiXSwqJEaJOvtKmaRP2Q/tmYhPdLud4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR09MB889505.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzhZeEo1UmJFWGhjTmUrTUdTWnNMMUdEN1JNazlYWXhTRWFlb21wUGRPT1Bi?=
 =?utf-8?B?V3Rvc211QngvRmNRU09Dc3ZKYVdGb25WNHdrQ0hTRzlIaXFSb0svMEo5Wisr?=
 =?utf-8?B?YklxcGVQczl5SVJwV1I2OFoxUkoyVHJ2eDNMWGZFT2YraUVpRnJra25ZRWF2?=
 =?utf-8?B?bXk0QSs0Y2FXNE5GWW1iYk0relpCVHlqS3BXVzBFY1BxazdtTWlkNmRIRVZ5?=
 =?utf-8?B?S254SHp0Nm1ic2Y3ditvZ2MyWGdqL0U2Q29TdkFCdUJkWHl2bWZzeUp5NFFD?=
 =?utf-8?B?c09rL1UyK1lQam9Za1FtOXUyMjNMVGJQSURsK0Qrci9aK3JKeHRNaGdNSGZZ?=
 =?utf-8?B?UVZ6N0ZHK3Z6cEdLVGdkUXVJSW9hZEcxNnRFd3Zxa0xLWFNYMHhuRkNmbWF1?=
 =?utf-8?B?SmJkT2YvR1ZtY2FsRlQrbTExZGlmbWtyNnYwMHdoS2pkN3ZKSmo5Q29kZUJx?=
 =?utf-8?B?UnFZY0MrNDhZdExPUTB0MUJrbXVjd2JEejhjUWZBaFZDdjBlV0lya1JkaXoz?=
 =?utf-8?B?bmk5UkQxbDZVeXZqWEhKRXBIbDRTVlRoRzhvWDRYM1gwN1MveVcwWVlEVDlW?=
 =?utf-8?B?N1ZMcHVxRzJuTDZHMHFqQ2lXL2VlVUZHZGlOVWV3QXBaQjBvZTdvUWgwcGta?=
 =?utf-8?B?Y1RTbXp1VUJkcm5sRThGWHlIbnNjOTQzaDVybnh4dldLNzhCUGgvR0Rlc2xC?=
 =?utf-8?B?UlAreXdVUEtwTkxjM1NaQmo5QiszZ1orUUh5NTJpMGxlS1ZBRDQ4eExhT21Z?=
 =?utf-8?B?TFppZzJXSmNaYWdFdm50VUxYYXk1UnI0Y0FGTy84TFZLM2VyNFlSdXhnU0tW?=
 =?utf-8?B?REpIMkVCeHFURVYrMEFSK0ZJWWJiaW1PZVlJZERsZnlocFdNKzZSaU5zTEhh?=
 =?utf-8?B?aWVUYWdKbDduWkpJT3FWOXplMFhnNDJnMUFqNmk1Z3c0TVhrc2ZHMytpRUE0?=
 =?utf-8?B?V3E2cEFSODhrWHl1U2pUaFdYUGEwSzllTTBPUW1BU1dDOEJjd1hSZ2gxeG9U?=
 =?utf-8?B?MldKZXJnazdaL3ZTS2xiYVRwQ1NZV1N4WUhPTEFmUkRSSy9GY3NlY2RZUlVP?=
 =?utf-8?B?QWcyZWRhd1IxVnhWdVdjNEhOSFkrTm9mTDg3ZDI3NDNnNlkwOWFuUE5ZV2JZ?=
 =?utf-8?B?T1Ryc1BtdjB6T1lvajBSOWsvek9wUjROSitVbmtSTVF5UFIrZXBLcTZRQWkz?=
 =?utf-8?B?Yi9WMUtTcmZ6UFYrVmNrN3dDNmZCbS94akRQM1RoeUl0NFRHNUZ0Z1lVTFhO?=
 =?utf-8?B?R3F1WUkzZVFna0lsTmtJcm9EMENHa1RseGo4aHhOS1h3WUtnUjQxN09tTUdY?=
 =?utf-8?B?RVVnOXp6TTVoWXBIdlFpb3B0MnNZS0M3Qmtseno0L3owRHVRSXgxaHoxejFk?=
 =?utf-8?B?cEZvOHJoK0hCYUYwSWM2WC8zbUg2MDBxaWlWQnVNWHhvVWhSekUzM0YyQ0lh?=
 =?utf-8?B?NGpWWGtwa2VJbmlTK3RpOG00YVRlalN4aitOZ21Hc1NUREJGZUx4OGpiWnhJ?=
 =?utf-8?B?QzZTSzY0anM4TFBLQm83MFVHZnkwcWJTRDJZcENkbXRnd2pFVUU3OWgwcCtP?=
 =?utf-8?B?dVRxU2J5dHlmOGpLWVVRQVc5QnlIdDV3dHNRbVl6dHQ3Zzlkd1hUVEhEaTZo?=
 =?utf-8?B?K1RyMWJlZXRwbC9LWFhFUys0VnVnUUJOY1RwdG9vTWpKd1BIMXZ3OVhMWitO?=
 =?utf-8?B?Mm15QVFYaEhqNlREQXhiemFnSEdGMXRhc3pWRWl3NFRLeFhkWEFyTENxZkxx?=
 =?utf-8?B?U2xaWjBDZVNpaVBQUFlzNlBibTVwQk5LQTV5QjdSSWlCcll2eDNkWHI0NFFh?=
 =?utf-8?B?V3huaHBJTWhyOGd3ZEo2L2JVMlM2Qm9nbUU2alI4aFpmZzUyZEw1Y0hZVnpL?=
 =?utf-8?B?YWs2V2w4aGxPL0JndFBjelJHVUJseHpSY2pVR0VGZFhwT09mKy9jSlo0NHEw?=
 =?utf-8?B?b09icEVoUUZqbXJqU1F4bVhRbEVSQ3BtWjhFbWU3NEJHOG9xNWRyc0d2cm8r?=
 =?utf-8?B?QlJMV2U3ODc3eVo1ZEtnQmI0Mm8rVmxlM1lmZ0JtQXdwc2N4THlrNFpLOUZP?=
 =?utf-8?B?T2JvNklQbEpOempxQ3gxUE5waXRja3pUUTE2bXdCQ295ZEJpMmRzQ3pyOTRY?=
 =?utf-8?B?eDZqeENBNG94UUdqSzZvS2xpZUlIQ0l1dmw3aDNRaFlTSjk3TCtDRUlQSHFC?=
 =?utf-8?B?c3VuNWZPRDhUbXl2cVg0UXRSMVAzNkp4L0xOdmUybVVBMTFUeXhMZUdYc2pI?=
 =?utf-8?B?bkNrQVM3RnhxVnVXOE05WGhtUHYrMEcyUVB0bFRFTzYveEVsdjg3K3Q4WXNU?=
 =?utf-8?B?NEc2S2k4OHVaY2dFa29uRTFaWVhOSVV3cy9yWHRzK2FEVnhzQzdkUT09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a2d3d2-b203-477c-a9a9-08df40b60fb8
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR09MB889505.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:11:20.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o42C4Sr7ILVT3C4nSn2NAgItR21LZlOqsQtp9l46hchKZMs44Ou4kcNWEeonzfmtrPAy43dpZXSHlI3h5wFCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR09MB191401

On 11/10/26 10:07, Anup Patel wrote:
> Making the whole driver synchronously probe is a conservative work-around.
> 
> Your original direction was good. How about the following:
> 1) Convert aplic_syscore_registered as atomic variable
> 2) Add another atomic variable aplic_direct_parent_irq_count and use
> "if (!atomic_inc_return(&aplic_direct_parent_irq_count) && domain) {"
> in aplic_direct_setup().

I will get to it some day. For now, forcing synchronous probing is the
easiest way to get things functionally correct, even not most flexible.

Thanks, Vladimir
