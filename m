Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A443F929B
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724497; cv=fail; b=OcAnGaG9AYLupJN/UT0JP5QDDz6J3u+4iuMcOSEQumnakRlvrzrXLQBumk6ePzNoNjodgjcBhjICZHKhYNcT9ZtcMLqsASoUaioN4SaMAOe/96vpqNAVrxn6tvZ3RJ6hx40clT2QTOJ9wnMfYlEZg9YJwnGj0Ynjp3SITyqWfnI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724497; c=relaxed/simple;
	bh=PbxAVlmmp8Vpdh/93GKPcZ76T3thjZn3Qm4my17oWxg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCavn0ogDS2fWApQyDNtrxOh9J4ab4t0E8oRlWXlU29FbMqieqqWUmx6L2oUzwAUq/OXdcfnrtuZLZr3C4Te8KA7dpGguFqxV1PHPSoIHHJrRwTffyRwG9W/pqk+ipUIjfZhyW8AqbdAlj8fp+MD9zMaA7pQ0dZsrFWsXj0xIQ8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MLMRKqKx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MLMRKqKx; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MLMRKqKx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MLMRKqKx"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=R4dUz/dp5Yas1M5Lex2LrFfn9uZQyn1ZSU8qKecFq+zsSELu/vnYTKiojCOGRo72w9MfmGlRM1afu//H/Ojwou8FKggs0cemxHrQE5kxQNeid8VHLxblaGiSg9HRbW2bPEJXRPCMSA014lhXZbavsRnVRq4LAySmz3yObY3WoU1vZx4C5/mtoDmkFEJv6VhxDTi4bG/SQOJscz3NoQ/HLbhDSUUrBGASoC8qMnbk6RYcinQqA6aK1y/f3SfAYbxHJE/9nOWoWm/3JDDu9LjvOwbvxfcmbsN91yCOm2V94otuCjS6O1ssImEFlEfQ9wH1eM42MAVgS5jMt7eYKqzxmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZMkWWpMvp7LftvQ4hwXn85GwZtPU1JvpV0MUF5hfSY=;
 b=foWBMaFFabzFlsDzdDmb9h2wgipzeKomHMPdBRs91mXiR54wgtR6o4PCryNeO0c9PDJj1o5gSx5odaxO7Yd+nsGDYV1Tib4su4wBceUwj7OqzsS1odG8eKBYMRFK1odiRuGEyh/rEpwj9Bh+NTACgvVMY3HjyIF/hSgFzwavFiB8f3u7XHPeg11/pCW2L9jx/0K9UfETVECx23GuOet5Tx/oAPA054y7QK4cePRGhAhzDk+lOtjx3/+XagcMhVuMgJrhkskn0liHSRwCe6jF2UOrAJ4VVS2ZhwrdiyFqPzAVoO3bZXnryvtbpgT82MyaV40Li63vls5oeCmb51mKxg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZMkWWpMvp7LftvQ4hwXn85GwZtPU1JvpV0MUF5hfSY=;
 b=MLMRKqKx6RZ56nKbX1duFypoEaYz98/E1M1j2ig56KtXmE6Ivb4LjBmKsmiz9ZbEXsiBdkP3nwUjvpj8SrEI22JG+ENSybZ4K/THqdkTvDL0/lMxYIB7SwEBAA3ha4T/bw/27IhnbX74KslslWz0Iz02wMFZ8KIq52i2i9HvBDA=
Received: from PA7P264CA0050.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34a::16)
 by PA6PR08MB10832.eurprd08.prod.outlook.com (2603:10a6:102:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 09:41:24 +0000
Received: from MI3PEPF00008488.eurprd02.prod.outlook.com
 (2603:10a6:102:34a::4) by PA7P264CA0050.outlook.office365.com
 (2603:10a6:102:34a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 09:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008488.mail.protection.outlook.com (10.167.240.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 09:41:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWqk5XtUsPKARXVOxRT7cLibFCzpqMmJeMDS/OSUJmFXUZNGF0EUv046VuQ7k27w6VJ8zW22Ftr12WehpYB8FuRiGZhtkg1ul58UAL0/jWPigOTSzhcL85RjyrQsw6ReT+9L6876qCVZLe5Hj1YNnJMm7wDLdpL3gVrhVdkB6vlGixmTa/hXCvlxc9uZ6fX9bR6M1Nt985D0hXP5G/1tLPmk8rQ58p2j3LudFd/f9e8NPI7r1M7R8itgvbWXY8Lc7jxiA6NUUHvCt84hUZ8EWEcsZnFPrFFemAftbq2zBm3OL5elYGKaV1hJ6i/rFwunGo47BuTj0x/7rmIpaq7WPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZMkWWpMvp7LftvQ4hwXn85GwZtPU1JvpV0MUF5hfSY=;
 b=d9UZ2/qoDaUeOwOR1Er3MZXj4WJWj7m9edVf/Y3yF/zI9PSp3kfKpbYdy7fhoaQ3GZ11m7pM22Ety+vv2fPCIRNzfD4NsJdyeQweMuK0X2a/TjbQY41zD83GRaMbBbe0WrGX/h4hGHfgZxreGg7RxPu8f4ezZczEY42qzenlcbHEF752968xI5sz6lTfR6bc7dPPRQ3U1kueiE9XNx/ZjoXiLZN+Yq1YfWV3hJmq5q2IbL7KYR5Dncd6t2k96n9dSR98HXDOqzN++2E/co3cTUQVIfI/iaT2glaHGGPnH7VrOMeAVLpTEPGcvMQWEIy9FSniicWO0x/CwPdHkwQwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZMkWWpMvp7LftvQ4hwXn85GwZtPU1JvpV0MUF5hfSY=;
 b=MLMRKqKx6RZ56nKbX1duFypoEaYz98/E1M1j2ig56KtXmE6Ivb4LjBmKsmiz9ZbEXsiBdkP3nwUjvpj8SrEI22JG+ENSybZ4K/THqdkTvDL0/lMxYIB7SwEBAA3ha4T/bw/27IhnbX74KslslWz0Iz02wMFZ8KIq52i2i9HvBDA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by DB9PR08MB7472.eurprd08.prod.outlook.com (2603:10a6:10:36c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 09:40:50 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 09:40:49 +0000
Message-ID: <784ab977-0247-410e-a2f0-b24962b2579b@arm.com>
Date: Fri, 18 Sep 2026 10:40:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] coresight: etm4x: exclude ss_status from
 drvdata->config
To: Yeoreum Yun <yeoreum.yun@arm.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 nd@arm.com
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
 <20260911-separate_etm_cfg_v2-v10-6-1b715d95927a@arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-6-1b715d95927a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::14) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|DB9PR08MB7472:EE_|MI3PEPF00008488:EE_|PA6PR08MB10832:EE_
X-MS-Office365-Filtering-Correlation-Id: a113eaf1-6b03-49f7-926a-08df156900f4
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|6133799003|10067099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info-Original:
 JiPC3UTsPOnmn0MeFY8dCmstf7GydQyXlapUA4oREX/TiYMbbLsVDyRZjgFKIF/zWUbK/F6jvyyrSYFhojidCnK5H2zUkJHyPGQDmyd4hcZ6WJouEMsQfCFXk/DpMZvIuTsqCOStb0PEJH4HcmHg4Y/aW+2HIB/yKzaDlqN7Gj/A4XuJxAW0ECsgo6rXdnTsGkYYBgjK6/rqLnllo+6HXW/U+un0x9MrTUYjJ1ay0WTHicXV9yQbfqTHHBDup+ir/GZtyE6/lUba//1jcoBNQ3Pa0eogaDU3BxFRMTqXHSFpM6CuTP0OM60DQUQku1guq8rcC+d0+RpaKPaRCFtpbPwrUfMgJ/APFzVAngIrujrICPwCt8YpAHzw/TYJpabQkQv3//3XN+cAcEY0WC3yW42BrnFjvsCXOUREdadeSzRhMEXJPWVi777ciLfGK5wydKuZvPNzjBQvTTB3NQ5sBH8o4ocKaZ25WkNlj2oQYJGrV+Xmj8qSnZozynj1+I55a5RpK+Qsg2qzVMQKY9/8mOrwoCEstSXxJIf+kPos9vvCUIRSVVV6bymxd+athyXLAXMTeIdnc5hG/Y5Cvp+CQlOrw/bXunyE+bedKnIWAHDbUmPdwjfFSdTdL16iB6Xa1G9exPZnadwVfHjZzF/2eaFAKwKiJBX+LeklrgKKbE0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 TvMJKkV4rt2edYWxWMktSSBHDBBoH+t+zLKVH0d47Lqt5yUqPuX9OMzz9EycoA7fGbEaPn+qJRyHe/CTIRtXlsWmj7wf0BWnQPEdzND1ekDSKjIJ9ytU2bcdpGUpjUm88LkiNMv5kti0McmzFZoCXxeB2iq+vLJBmGusdhI5iSt0lhhd1C8esSyRIEUe8u1auXajApj1WZkQw6i9flUhbngpjuQVj4bNLqc6txBocteCIn6ssMUcZeUpEQ11saJtCPF0bSBJNCi7dQfySx2z0/m0zYNTy3y8+aCXuZ9x/XWnzruLKr5aslj7yH0dkBnhE/Rr4K+tIuoI/NSDmt6WrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7472
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF00008488.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a41b0a3b-7139-4166-98bc-08df1568ec51
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|82310400026|376014|23010399003|1800799024|7416014|35042699022|4143699003|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vCm1V4aXNcvN2/psErZiH84+oFYmXQUpXLgtUezhvc1Hmz+W9gGPiaiYmxsji0KgaJC3iCVk3fDhZdRhwffnktYbH075v5SdD/dby7WUBkS3dXaDgyWAtbn8B/83Zds0drUXNZJD1L9Ue2pNxheGG7V2WcPNfF3d6gLvb4GJJRoCSqpI4opCDzHFzjbuVh/bE95goEjrTp+h7nAfLSsfKGwsLbVdBfPqGepSlaa7+e94x5YFTfGc6rhIPhHpsNasR6OHpYUCH8Dnm2iplXCUD2bY8Clyl15fmEUIdboIyLLRur9oRlNWx4273v9jOZd0UEoiokgZe8O9pWBiOwKHoXeZLsjAGSiiUekKuU4M5Y9xcA/zR0CFVWUjeFj647uoIgDd6FDwqipbu2Cu1zq2+0p5me6mjfbwf22ZrdeIuYZj3j00iWKdE9FYr0aVSu/5cFypetImaF5+cIvLyOl9nKKjizTGC79SWIheZ1/HnlQAST6k9sZw70F+lNVmVnnFbgyNu5nfAiAjqpx9uRSnG8D4uArhTQrpB0bwiuDd+pUEtLYWsdBMW4/G0IlEDyBSd/dnWxzlLD5yk5oe0KvlCbKFprv2LgdiilPz5WaJ56KcTF5sdIXxe3DCqIweMCIuVh5CieuIq14Sh/uitP9NWxXLSyLHhoXgYA1D6dOdeBx7PJcDfDpu8ZcOMCd1ZmOZfyA3PspkCxy1CqongqJZuQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(82310400026)(376014)(23010399003)(1800799024)(7416014)(35042699022)(4143699003)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G5WmHVh3EcTurj/a3KC4wbm8K5QsTDNQhMV0ZMJRSu4zCGciIRVC0S7hVgmufvOdkDt1A9rU1rpvha/9hAc1uBkPN86G4JU4/xUlT5nvrI91XdsdbMNinX6FWxsUVdYxpcLx/0GcbpXezE3KtAHfQP47mNyDVXt++b2n9bWRqDDDX0OKXpd1Nh3LNb5bCyPuCfmlOVgPuYWRifWF/xoQf9m7d4LeFPviqLOCQdWJLUT8Mna9BKBFX/ILDu3fKO9K036bpNmzNUHpz9AsGPtIvnFFbv1SHAcBmPMPbWQq7z61vWcUzgNgxD0qk2EukK36gyKgL+OaIngREPWe9jFbT9wiBn74gqa6/xbiVoX3sWAvZ2RZIZRskxjqiG+Gz3IdyTIv4yDpBq+zQPTGshgMa1XIOQ5cU1VzKtnhlpMaT9HUeLUZUYFx2WLSAER1tdMs
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:41:23.9666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a113eaf1-6b03-49f7-926a-08df156900f4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008488.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10832

Hi,

On 9/11/26 11:56, Yeoreum Yun wrote:
> The purpose of TRCSSCSRn register is to show status of
> the corresponding Single-shot Comparator Control and input supports.
> That means writable field's purpose for reset or restore from idle status
> not for configuration.
> 
> Therefore, exclude ss_status from drvdata->config and move it to drvdata.
> 
> Before this patch, clearing the PENDING and STATUS bits when enabling
> a perf session could trigger multiple single-shot events within
> the same session. 

The hardware is designed to have multiple single shot events - the reset 
bit in TRCSSCCRn specifically programs this behaviour.

But the basic point is correct there is no need to have the status 
register as part of the configurable set of registers.

This issue will be addressed in a future patch;
> this patch intentionally preserves the existing behavior.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-cfg.c   |  1 -
>   drivers/hwtracing/coresight/coresight-etm4x-core.c  | 15 ++++++++-------
>   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 +++++-----
>   drivers/hwtracing/coresight/coresight-etm4x.h       |  7 ++++++-
>   4 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> index d24f533c623d..098aabd2b922 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> @@ -86,7 +86,6 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
>   		off_mask =  (offset & GENMASK(11, 5));
>   		do {
>   			CHECKREGIDX(TRCSSCCRn(0), ss_ctrl, idx, off_mask);
> -			CHECKREGIDX(TRCSSCSRn(0), ss_status, idx, off_mask);
>   			CHECKREGIDX(TRCSSPCICRn(0), ss_pe_cmp, idx, off_mask);
>   		} while (0);
>   	} else if ((offset >= TRCCIDCVRn(0)) && (offset <= TRCVMIDCVRn(7))) {
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 6d64a3fbdea4..68aa99e8135d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -95,7 +95,7 @@ static bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
>   	const struct etmv4_caps *caps = &drvdata->caps;
>   
>   	return (n < caps->nr_ss_cmp) && caps->nr_pe_cmp &&
> -	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
> +	       (drvdata->ss_status[n] & TRCSSCSRn_PC);
>   }
>   
>   u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
> @@ -573,11 +573,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
>   
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> -		/* always clear status bit on restart if using single-shot */
> +		/* always clear status and pending bits on restart if using single-shot */
>   		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> -			config->ss_status[i] &= ~TRCSSCSRn_STATUS;
> +			drvdata->ss_status[i] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
>   		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
> -		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
> +		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));
>   		if (etm4x_sspcicrn_present(drvdata, i))
>   			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
>   	}
> @@ -1081,7 +1081,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
>   
>   	/* read the status of the single shot comparators */
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> -		config->ss_status[i] =
> +		drvdata->ss_status[i] =
>   			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>   	}
>   
> @@ -1511,8 +1511,9 @@ static void etm4_init_arch_data(void *info)
>   	 */
>   	caps->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
>   	for (i = 0; i < caps->nr_ss_cmp; i++) {
> -		drvdata->config.ss_status[i] =
> -			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> +		drvdata->ss_status[i] = etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> +		drvdata->ss_status[i] &= (TRCSSCSRn_PC | TRCSSCSRn_DV |
> +					  TRCSSCSRn_DA | TRCSSCSRn_INST);

The unused bits in this register are RES0 - rendering this masking 
redundant.

>   	}
>   	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
>   	caps->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 2d8a8f64a038..ac290f446c51 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1829,8 +1829,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
>   	raw_spin_lock(&drvdata->spinlock);
>   	idx = config->ss_idx;
>   	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
> -	/* must clear bit 31 in related status register on programming */
> -	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
> +	/* must clear bit 31 and 30 in related status register on programming */
> +	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
>   	raw_spin_unlock(&drvdata->spinlock);
>   	return size;
>   }
> @@ -1844,7 +1844,7 @@ static ssize_t sshot_status_show(struct device *dev,
>   	struct etmv4_config *config = &drvdata->config;
>   
>   	raw_spin_lock(&drvdata->spinlock);
> -	val = config->ss_status[config->ss_idx];
> +	val = drvdata->ss_status[config->ss_idx];
>   	raw_spin_unlock(&drvdata->spinlock);
>   	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>   }
> @@ -1879,8 +1879,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
>   	raw_spin_lock(&drvdata->spinlock);
>   	idx = config->ss_idx;
>   	config->ss_pe_cmp[idx] = FIELD_PREP(TRCSSPCICRn_PC_MASK, val);
> -	/* must clear bit 31 in related status register on programming */
> -	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
> +	/* must clear bit 31 and 30 in related status register on programming */
> +	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
>   	raw_spin_unlock(&drvdata->spinlock);
>   	return size;
>   }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index ffde48b6b41b..8c1c1364b1c4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -213,6 +213,7 @@
>   #define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
>   
>   #define TRCSSCSRn_STATUS			BIT(31)
> +#define TRCSSCSRn_PENDING			BIT(30)

Minor nit - PENDING is ETE only - worth commenting in case a reader is 
looking at the ETMv4 spec.


>   #define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
>   
>   #define TRCSSPCICRn_PC_MASK			GENMASK(7, 0)
> @@ -730,6 +731,9 @@ static inline u32 etm4_res_sel_pair(u8 res_sel_idx)
>   #define ETM_DEFAULT_ADDR_COMP		0
>   
>   #define TRCSSCSRn_PC			BIT(3)
> +#define TRCSSCSRn_DV			BIT(2)
> +#define TRCSSCSRn_DA			BIT(1)
> +#define TRCSSCSRn_INST			BIT(0)

These new defs are redundant if the masking above is redundant

Regards

Mike

>   
>   /* PowerDown Control Register bits */
>   #define TRCPDCR_PU			BIT(3)
> @@ -980,7 +984,6 @@ struct etmv4_config {
>   	u32				res_ctrl[ETM_MAX_RES_SEL]; /* TRCRSCTLRn */
>   	u8				ss_idx;
>   	u32				ss_ctrl[ETM_MAX_SS_CMP];
> -	u32				ss_status[ETM_MAX_SS_CMP];
>   	u32				ss_pe_cmp[ETM_MAX_SS_CMP];
>   	u8				addr_idx;
>   	u64				addr_val[ETM_MAX_SINGLE_ADDR_CMP];
> @@ -1071,6 +1074,7 @@ struct etmv4_save_state {
>    * @config:	structure holding sysfs mode configuration.
>    * @save_state:	State to be preserved across power loss
>    * @paused:	Indicates if the trace unit is paused.
> + * @ss_status:	The status of the corresponding single-shot comparator.
>    * @arch_features: Bitmap of arch features of etmv4 devices.
>    */
>   struct etmv4_drvdata {
> @@ -1091,6 +1095,7 @@ struct etmv4_drvdata {
>   	struct etmv4_config		active_config;
>   	struct etmv4_config		config;
>   	struct etmv4_save_state		*save_state;
> +	u32				ss_status[ETM_MAX_SS_CMP];
>   	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
>   };
>   
> 

