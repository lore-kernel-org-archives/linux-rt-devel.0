Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEF8405F7;
	Mon, 26 Jan 2026 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420008; cv=fail; b=h83O590h4VVrUXiG0rGT6XBrPiFsSisLoxenE/Ldt5fzQqyh8Bg628dK9rtupG7wCl9RoE5KGwbvLsduzDWCJSWFWk94jb9fVYLQ/rGOTUI9RPqSqtv4OGHJHmu5Y9J3PxN+lVprm+cMQbchVuFKgo/N27NTd+YqJ7l+P1kUhaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420008; c=relaxed/simple;
	bh=Ip1eJ53M6VoXLKGk1ynVaMbuupr7jMDnInSl/vSoL+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+n94ygFAKIC+tMRzbggt9VRcfwIU2JNsHy1EDfqMSneSAsVGyx9hTfKfGvaVn+HjXCLGRVspyrIxFFt0tsVTLFULF49tFMp9XHSBPGpIvyTXiERblP7LfMZSHb+bsl8J75nLYbVSn379Y/rdqkqRcJf/JLbhNS4Uq/WIuwkd2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VQPM/qz9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kCqv/VMu; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VQPM/qz9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kCqv/VMu"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q50PYs3319387;
	Mon, 26 Jan 2026 03:32:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=zDspPmX37xnegj8ZPV
	c4ECWI02jXthzbKVLdRNiZEC4=; b=VQPM/qz90nOddXrvRyEiXsPuJr4LRnDynM
	Uxt03/tbzlIJBbIUgIUuGfZC3+TTHLZJ/RzVwrm0uNpPw4iiNBr2snS+kufC9ABb
	9GgHXCVXeZHyxJy1CVUKkKVVhhSdBvbiEcSE1bsx1FZT6MY4cGX86GY5Ok0ad+Bx
	m/A+sGpQiApK1ZrRwEqyjON5aNrwRy1v/7kD7GmHcy1RwWNL4G9GYcsQ8L77VBhZ
	wXZJRNFDziyW74BUE6nUx+aTIlyB6unVW70moQuRuXa4N2J5r4jwJziX21zjBhsn
	pBYHk0P2lGPH68+aiFQ9EkChXlQAadt/pz0I46TFeglAKUGYV5fw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020104.outbound.protection.outlook.com [52.101.193.104])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4bvuck9at4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 03:32:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZdymthyCsG3nZA5PcDGU1R+21TFtZ9Ns4+5ntlEK+G1DtSRwmGzrwY9SXhiohpcW1zuFhEvBwMO1Dif32y207SV1whKZz267I9N09Gc7R/qRLZMjBdPHo/ILt3qbg4vM3DrknQrcWSnpbli2dbKkQeROaCq4Y0d4DLk9xxcHQhd3TrGpp7VSokPvsWBfvLiQwq7gE47jqPxq7z+vs22pdhQjdNwCjfUF2de4HRugEsBE0Lw1AVU1s0dGBkgmHJUWB9xuN3NRpjqZGFjNHk4+3rO0yrK0h2CecNQurBDuuFo1132TcZfZRDTgJHdvE5kOB/e4+0ipayQWC6RC9DLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDspPmX37xnegj8ZPVc4ECWI02jXthzbKVLdRNiZEC4=;
 b=NknyqesJIZ/IRZfuSOZSvEClVriyV5UI4DXslZi9N7tBcF+XSqnq9ZBAhrlf8vDIbSmeRO968UOOxrxbbPQl3ja5iSpyc4XC8uojZcO+XDjsnRZiHUG91Fa02lgF7jR3/AgFWDYvxW6N1qiWS+qYzWLC2qe+l7H2GS1nx6UbZFRI6Ufv0v+ii/TX7tjNM5nmH57eJFbaEIKtKvHJDCyhlcI+QPnFjbrg/zmqsgfuyOLK4LlKcno/r2reI7jBOS3JcAGvCUqEnd7JFq2fS1YP/sKnXCtEbYd9QFeuKmnPyRV8rLbtztqTCUg8OdwPRHixUQ8gLApHU0fUK4YxdLxhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDspPmX37xnegj8ZPVc4ECWI02jXthzbKVLdRNiZEC4=;
 b=kCqv/VMujoCHISJ6pESjfdPE45lvt62fDQRfF7G3MxQ8v8RDjNeegyRs5bxFNw/VxXHSZvHFnqvaEqwaeRyz4L7PB6kp46FNEZgpRGMPvVmcOoUGKWrJuolNRmwxCz4U9vgA5RPAm/g/iMEHJV/i4Hj+bo1yOlEHqiQ8keVHQG4=
Received: from SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::18)
 by DS7PR19MB6304.namprd19.prod.outlook.com (2603:10b6:8:94::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Mon, 26 Jan 2026 09:32:51 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::e9) by SN7P222CA0004.outlook.office365.com
 (2603:10b6:806:124::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 09:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Mon, 26 Jan 2026 09:32:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C3602406540;
	Mon, 26 Jan 2026 09:32:48 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id AAC29820249;
	Mon, 26 Jan 2026 09:32:48 +0000 (UTC)
Date: Mon, 26 Jan 2026 09:32:47 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Thomas Gleixner <tglx@kernel.org>, Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        patches@opensource.cirrus.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/21] mfd: wm8350-core: Use IRQF_ONESHOT
Message-ID: <aXc0v13f00MvspTO@opensource.cirrus.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-18-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-18-bigeasy@linutronix.de>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS7PR19MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ce1158-6914-4ede-649a-08de5cbddfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013|30052699003|7053199007|54012099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqEnIPxTz1cXCsQbBZMb25TgahxOqqxArdL5bVCleHWtQPvMspfQKou3wcq4?=
 =?us-ascii?Q?h8ku6BwQGMovW1B5V+IJUMCot1S+ggRluqWM44lU/r7N2eUWx+t4OrAXRG5A?=
 =?us-ascii?Q?El7+z9KBfl/h9b6XQ13+bza0ptGeidsFrImPgGhAkG2Wz+IBEfyYxvuQV0YE?=
 =?us-ascii?Q?sRTFV7N2vxoDcMgsu0Me0U9kMvq3Ykb8J3sHNwJovJU6Ze3HJsPKwVgAMZiK?=
 =?us-ascii?Q?4h1RvVzrsshqUpkEW24KXIAsCcWZBHl4KvPJwqGBwniuxfXG8ci6d4Y9p7ns?=
 =?us-ascii?Q?/BMQDqUV5am1t3Z+U+w7R304XzBCWY44bar9C6WUOKsNsXqc1theG0fG/brX?=
 =?us-ascii?Q?W0OX0U8kAP3jio15dGw/Le0/lK7xRsrH1dthHsmw/V8a6x+McTTBtnFO5SIk?=
 =?us-ascii?Q?H1AfjKtiRUC+P6wBJhl8zlpKHx4QtwbcTKO4sv0/vl4KI4YCYIFTziZsk84x?=
 =?us-ascii?Q?/mBmDINqJaiHO2HQYnOvWvpUvgp1NObKKZVwg+tJnnthKSoYiuuHGCPuWgRR?=
 =?us-ascii?Q?4x2gji5F/aTz0qkNjafHo0GyCshBK5qTkPFaI66Wtksmc/+FZ9NB+9YHjT2T?=
 =?us-ascii?Q?0D/lio7CPOjUd/J+qnqcNYXsDh9eiIKHDWekDv2oQm/BDZPaikS8sEGiAOmU?=
 =?us-ascii?Q?sIAg1J53GeMH8mbVzh4wKXGD4AQ/s1gp4NWX5rcRyiqiVEPct/4C49wffdRv?=
 =?us-ascii?Q?580ki9mEkvRvBbnzMtRCPD+Fcw4ukCKJ34rwcdNaY+aCtuBr8QoHMgqvC6bz?=
 =?us-ascii?Q?hJhyRKCN4YVQO5LqxlgC4kCX0OLLhvNrYEKuZNUYsTpfstIIp83z8AdTP/uC?=
 =?us-ascii?Q?FBUWPR6COBg7p7WwI6cCB6WjYDDqEhm8cXmflYVyWcOr1CcI5lX+xNG9nEns?=
 =?us-ascii?Q?dI1YloVwjl7NV1fqPRPcp4eJ1iN/qWYnzsqQvesy6sfKtwKurWjGF5DmKzZB?=
 =?us-ascii?Q?7uIkHG5RRTN5udhLSEzicFjuBRpArl/rsinfxLXHKU2c7DUxg6opGgzCy415?=
 =?us-ascii?Q?ss2173qR9O2HYScEPMEwtWSC4u8De3bA50gYAzBBDowSLLKIgCjeEFLYW7NM?=
 =?us-ascii?Q?qAtVQzlK9FhhdDeui9q18Ock/JpKxtRZQmJ/BPu993/y2BRYRZIFhATscHKe?=
 =?us-ascii?Q?Q/BW1zv+JXMeK2B0dMTtCtbQ2qGggLYUUJtoVySsOQMNWKL1PLBhb/Mvi1J7?=
 =?us-ascii?Q?1RGWg09S0wY3clbkiU4tVD6RT3uMfW3YIgPiO0HXfuxbwbPbmSxP0hXgWs2A?=
 =?us-ascii?Q?mcf3NAdgSijf6MVJmHZjbbOWotK05qSkHyWeX53weXNj2LNCaH9iiJ0mWVoW?=
 =?us-ascii?Q?3pixutMGKbJJ1o3FTOT3cgIrl6UKJbHLjxjShtwHYWfMmRMMe6Swdu9VHpSU?=
 =?us-ascii?Q?81itAH+fKUumsogge0qmdxLfNsyPmRsRnDrmw9Mt0UxuGwZFdIacEDABWCFo?=
 =?us-ascii?Q?rxf//K0DJbh3tZIZOcNV73WV3lwpOTpXxD4DUMM/f/w5304i7FQOcbwlpy0n?=
 =?us-ascii?Q?sgmQXVYlbXr5SRfko6NjSOQnGBd5KxKQW6Fx2KAEVB8TQ078A74hLaY6ZwH+?=
 =?us-ascii?Q?agjPmcLb8Lgk6LwhzG8lEZhuShOZkDowjaMlvZBr10sXkA3wi8JSIFSyT0xW?=
 =?us-ascii?Q?S2jo3NZGnS8oHogyZRXVqDn+aO/Oc/xiMcE6ORh9/CC+bj8j70NGr1oEPnG0?=
 =?us-ascii?Q?B4UJ+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013)(30052699003)(7053199007)(54012099003);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 09:32:50.2806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ce1158-6914-4ede-649a-08de5cbddfbe
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6304
X-Proofpoint-ORIG-GUID: LdC64doU6-ys3KKK6mV73eitrlGzq5mZ
X-Proofpoint-GUID: LdC64doU6-ys3KKK6mV73eitrlGzq5mZ
X-Authority-Analysis: v=2.4 cv=Vb/6/Vp9 c=1 sm=1 tr=0 ts=697734c7 cx=c_pps
 a=vLRhozfdQXdtFHbAT0K/AA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8
 a=8MeykaVjqZUA_vSaqCIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA4MSBTYWx0ZWRfX2QGL6uhOOSSA
 nkLxrZJUMOVhC0jKSRR6CCu8RzVYKcMlPttvKoF+cK4Dbxe6zv3YyjRLPBlkk87Ka6jaouTnPK0
 bUQEPUwmKcaSBrC8pod5SN9ghkJjOXfLTSi3qP9sALSK5Fv6anVzIekXcDF+xd2Da+KGdJ4QNhD
 x5A4FW1fmOtpj7TdUilktIkaxYTW9RjwUVfn4qGNXjGD3HztoABVpNIQC8u0ZYLyHum8paYe1Cb
 2tCAQleuEnmZHB1WsaCwGz6DseoRBY26Yvt2Q8kebcUVh+pTBC/p1R1adzqVTzgjmKyAn0Oj0IJ
 2fa07RKgUQJEIpmnJ0/A493KulXNvseYHJOBQGDBD7KNIMBjjTs6rZiU74gGp5mZv3uo1ZEF6v5
 Qi5ya/vbV0MPfTWJL/NrQyQhBD/KBbtXgZj3lZN0WfSAhmTz4oiqqugo2QuCFZqWwvUdy5Dg1hR
 3rD/cKQJS+Qc565M2ZA==
X-Proofpoint-Spam-Reason: safe

On Fri, Jan 23, 2026 at 12:37:03PM +0100, Sebastian Andrzej Siewior wrote:
> Using a threaded interrupt without a dedicated primary handler mandates
> the IRQF_ONESHOT flag to mask the interrupt source while the threaded
> handler is active. Otherwise the interrupt can fire again before the
> threaded handler had a chance to run.
> 
> Mark explained that this should not happen with this hardware since it a
> slow irqchip which is behind an I2C/ SPI bus but the IRQ-core will
> refuse to accept such a handler.
> 
> Set IRQF_ONESHOT so the interrupt source is masked until the secondary
> handler is done.
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: patches@opensource.cirrus.com
> Cc: Mark Brown <broonie@kernel.org>
> Fixes: 1c6c69525b40e ("genirq: Reject bogus threaded irq requests")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
