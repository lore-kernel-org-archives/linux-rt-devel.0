Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB22F617D
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766048987; cv=fail; b=f4fEnqt+oUiwov/CZPSWgJ7nFGCW1pO7d0mhqNVk0TBg8PwvUuVZ8fWn2OiQlayVn7IHJLIZYHOONFQtNBME9PF0oQzj7dsrJ9EAI+ctAwfVEcYKZFZWcU7O2nqA8GHr9cySxAahdij+nHoybky40uegoSZvzlX3LMeOsvrTkvw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766048987; c=relaxed/simple;
	bh=cjDK4p+lUzJ2KxJAa4CJcVL2YyCaA79Fxdt0ttxFCQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pkmnCM+ANsBLMDRtBo2vg/3tbPcgSPimCm3XyZDsvekR552xHX5jEk2OZaki2W49Ad7NNn8GSyRl+Yvd9yLLXijyLUQYkPBa8iBPz4KZIWVyi9eNcXA1X+wYvukhyMXo7sw0oWtZgj1HWd+Ef9yVPFXYoFL0IzgoE3A5CrjH0Ak=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dcg37xcL; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dcg37xcL; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dcg37xcL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dcg37xcL"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HICqDD6qEkcbgU5mj88ioFwl/Eys2/tl77UE+KStJsQHTvmRt4wL09nKUlFqJjso1wBT1E3gbheEipEzp0e8zr1LybDOilbhf9dEzciZdY4IeTWbqBHqLxD9CwF41tVAkiKsdvkZdG1vqXTH8vnGNORaYw42N9SPrz1A8nWcChn4V5BrFzeG3qP8KIFI3m7t546OskCrM/CaLxP6KCtAQeVuiN3BSQQoefM7nX+NtB4m9a258k+YMq01jVnuB71SqYmnYycDMNGbeDEXflCP/LuBWpb/O2IczQ8721paC+52dm+Pz7z7Q50jL/LvXWr4SABArtsnJ2pWrXFdjxDjsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK3Ma3TYRouGEVgO+1dJpuIsZgzzQwie9ouW4hszVgg=;
 b=cF3Rc8UiQ1hfL15m1Y5EdJ7OAh7nykWpuOIhbpzaluHmfQoZARPdvaK9/anRuy/xz8VbykU7wDGeQUU5fW3sYmUuztWc2lm7v7AWCyRbrr/NjNYsBNiXZHr4LpXbv4PrIma4+WsfW9lVaPULGCJdQg4CZ/90p9H2OSlBizbE/vgKqOAZiv8SxDHwTf8xLSjVymXw6XqDfGFo51cLXzngaaxgdfXuTb8ESvaqKwGOlqpcobnPqjzRS35MXePW17aY2f+6EQiqOTGV4YUe2hhEYwx23KFQfnkutrVme6K6/L1OHUj2RCKaEeXYiecTDJgB5TSTk48uDXaD+c0qMtoU8A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK3Ma3TYRouGEVgO+1dJpuIsZgzzQwie9ouW4hszVgg=;
 b=dcg37xcL4/HaHcHqgtZo9bQwyjnbsbflNvcOefgB0HkHxZmezqOjIkd49ozCBMg5vf7i7/7acKige/mIngw0yFhiWGsghyaosoVvs+3uqnLM0SsGJp9KjCLfcKDudpMgHfM76cHqHOUx+lpiT4CXMmT0HVmBe9yb1bEyXyHe/ec=
Received: from DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) by DBBPR08MB10507.eurprd08.prod.outlook.com
 (2603:10a6:10:53a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 09:09:36 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::a9) by DUZPR01CA0350.outlook.office365.com
 (2603:10a6:10:4b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 09:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via
 Frontend Transport; Thu, 18 Dec 2025 09:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVZVAF8DfdQBdvwkrAoethzf77Ub1kxXqQD0MtMqiUKv9wQgkZbjsAbcQBjjPWfSMHA4oMIEkX05fU+KkmspX8cgqaoyPv7eXUe+nO6IeX8wGUNcn0O0KGv/pnXoFyzInhJhSyzWsYgcGXjIWd8T5P1S30MlHMMJuU7+jL7mcKN6cIm68aPYfCJoWMJ/C0JpL72+er0N2vgx3+aRff46hlVYwmefTrAYYFDRlmsVO/jScM/e79PylGEUIDb9FvmTzuOi9rA7RRxjjFgBtlbSuL5QLog/FM3aLd24FRNDS+S7c++bTUcaWE6sLGTeeu7sVqukECow7X6tqWKafA+c8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK3Ma3TYRouGEVgO+1dJpuIsZgzzQwie9ouW4hszVgg=;
 b=deiQRhvgtPYXlY9fOK+W98TFcZds3b5z9H6RJXcUqqQ4soAwgFKNI+i365zDi0cMV5GMRB6MLieL4OgoZ//g0/K/1qkgdQkkAxU8t/TAVE3i250fowSvrcK0qy5jHMt/jzLCnijp73zve11UXg7WDrx1jE3zt2pWfaAYcZySR09FW+7spYJoyIgvZ9C3ZpyHME9MpCUnHOn4Ns6ksq1IAD24jF3g6lZt6oDquIEgUydq3vd/WGQCxZ2JO5RztLBC315Y6IkWmfpXbo7JYvAYyh4odSW6x1k5AoGWK8aP1pw+ixRYIVofB+7hMY4Dy3VXvU8oeLemkd6sUGTB8iVZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK3Ma3TYRouGEVgO+1dJpuIsZgzzQwie9ouW4hszVgg=;
 b=dcg37xcL4/HaHcHqgtZo9bQwyjnbsbflNvcOefgB0HkHxZmezqOjIkd49ozCBMg5vf7i7/7acKige/mIngw0yFhiWGsghyaosoVvs+3uqnLM0SsGJp9KjCLfcKDudpMgHfM76cHqHOUx+lpiT4CXMmT0HVmBe9yb1bEyXyHe/ec=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS4PR08MB8023.eurprd08.prod.outlook.com
 (2603:10a6:20b:586::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 09:08:31 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 09:08:31 +0000
Date: Thu, 18 Dec 2025 09:08:28 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
	akpm@linux-foundation.org, kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
	vbabka@suse.cz, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 1/2] arm64: mmu: don't allocate page while spliting
 linear mapping
Message-ID: <aUPEjPvJdS/QxGyt@e129823.arm.com>
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-2-yeoreum.yun@arm.com>
 <15777c12-d732-42e6-83da-61b3dca3764c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15777c12-d732-42e6-83da-61b3dca3764c@kernel.org>
X-ClientProxiedBy: LO3P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS4PR08MB8023:EE_|DU2PEPF0001E9C6:EE_|DBBPR08MB10507:EE_
X-MS-Office365-Filtering-Correlation-Id: 309ad025-ba67-42b4-c9e9-08de3e152a97
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?zuA+yIBbtxVCfSauvvp+iII5g2mnHBUTmekcvh7DQzXEHREwQDt5VWCWPYgV?=
 =?us-ascii?Q?30baVK0VLI0szLry7hpgpEHj1+/MCJYaTMMs7wneiYtNjb78o96mOaEZbu/0?=
 =?us-ascii?Q?0XtEBWR4tMeD4X8yf/PnVbo1dIom/7pGs+qBV2affeGXpuPlg8LDxNJ8XRq5?=
 =?us-ascii?Q?wW9dHWb/NNLAgAU70NZSSfOflGlUgm5hP6xpTmlS7XvILFHuRKcnW9s9/+PF?=
 =?us-ascii?Q?tH+aS777uqEBuU088irurE05JD5EESEJrJLGbcmknYUvyBV4DnUuRKzxdkPq?=
 =?us-ascii?Q?6K1KjILXuwGNddv3tFRbr6yCqj59Yfz2Anslo9d51uEC+hh6GPfhiLXAcK/y?=
 =?us-ascii?Q?KJ4pzeGur9M1+MesM9VII6n/3Bw9N1WcVwbo6KeIQOBUsYKPLIIFUeaSKoRx?=
 =?us-ascii?Q?LbIM2pNmcnXXjZDSbEqAtX9vOCOT6Q3rOY39n4EDtUm1nushimTpLZyWZ2cN?=
 =?us-ascii?Q?pipCx9TrNj186yhouj4oI5BdtrYXfO3v6RhSuEVHUQbpX78gp73N6o8RN2bq?=
 =?us-ascii?Q?0PpUJSAivFoUITvm7wjr64h+mksY22BPD7IA3dEr6YcvtFkG3gY7cUG7IVqn?=
 =?us-ascii?Q?I890UbJPYb1mSx+pqp1JziJaI9e8UMcmeOqUB2rLeZNadKcOxfmcCKIQ2qPP?=
 =?us-ascii?Q?0PY/2jWbhw17Km2DgHtMH8tGgkaFdGrtU7SZJ5nZPkU9cgLtoa430mQEhLPy?=
 =?us-ascii?Q?M+eYJU5ppgKUN/04/l33KUwT2eAXKLB1cRL6a5DykAsl9Jw5zM70fTThtY8V?=
 =?us-ascii?Q?u3oWGmyPi9v76Ckon7AYFzHIEOItfNnI2o8n2UZ0BeLsOnbet7tE1IkCQbGw?=
 =?us-ascii?Q?u8qweEhc1zLlCK3f2J/FfrshtuVNB7IcFhOuPOybdoy+31tcQ70NLUbMr3Kh?=
 =?us-ascii?Q?3xIhr2fVBpX5gjKCqHxU40Z7X+Ghd/5Mr8Dbwh5XVe5CGDWop2qcDBSx9zCC?=
 =?us-ascii?Q?Qo1tpzte+deT57kskv9YWdrsHrR8s9P7/tv75rIupMqk9b41d/fNOHWFJDsV?=
 =?us-ascii?Q?4zo1T3C1QCiosM6ZDoB6EDvTGWBi4jdj14boMNmukvHst61m0qUHtkhWfIhP?=
 =?us-ascii?Q?q19c9hhVLIEud02iQ8BW/dY75k/TvM9rkWCvSpW/+PCm2Oh4jXGPmPnjFtk/?=
 =?us-ascii?Q?M0aOrfYgfqJCI+6qdo1xfHWp6FXqTfYWMqQpLRL/OS7vTugqf8bLfO8SaFB4?=
 =?us-ascii?Q?PQgcZMmVYpiDVW53wwxlB1FKsS6QEjcdFQ0AMYGJL0+PfEdU7M/mBiWaOVyD?=
 =?us-ascii?Q?VpmNJOdUj3FKNKitB1l42elqRiKpixk++DFA0egDOZCRMx26exCl4RErTvP1?=
 =?us-ascii?Q?ImS/+HaSkvPrwyfBVW0m82L+Q6djqvZpAa3bic3VYZl4C2u+hRav6M5kvEhA?=
 =?us-ascii?Q?9fGUDJU+S9pwC6Fqc7FLkEOKunrzYCb8ATEalKG/WJNcEfhida/vH3HWzR1T?=
 =?us-ascii?Q?O6hpH9g1MPiRzgSmaeNWxnBdaLxUxXDS?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8023
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	60bcec14-a2bd-4c29-f830-08de3e1503ed
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|14060799003|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2nf2DAZUO5Q++eCLCyiRgQhQ9tsFmLuQTc3tw7CnP5TdclNMULbizBkvvkU+?=
 =?us-ascii?Q?7EtvnJGwnyOHJjKCZqQh5LIiV+RQ5OK+vFWcXNGinJChIfETzq1GuftXD6oq?=
 =?us-ascii?Q?/OCrqeWSc8U1LiljW7YEnbmTQmNCZt8/DKP/ohUdlkNTL/Q+TKf27sd1sg5h?=
 =?us-ascii?Q?z4UC5epEOqn3ztau90V4DQzQim+z5BJR7oEue/ahUWS3T1bp0X3CS7Ei86RX?=
 =?us-ascii?Q?QHjF0vSsdCuX6wuHhHqNT+exk8whEkZjAWSLCGNSnDPpSp4qZR1Qgj6qI/Ai?=
 =?us-ascii?Q?yxJkbE69lAmGoVESSB3QQwVjPMk4JYZ17NYpx5xlVdx2Xv+1MNpO1KBBRha2?=
 =?us-ascii?Q?86hBl1ljT/d1Jvwz1RQxDsJij+0EdGWD6kiMHjn/evWb//YB3uCp4nkBKJU/?=
 =?us-ascii?Q?Uutp/XTxi1R0UMDPUIkSSjeTwjBX0kzvvH3rFQ5OkPbJV868kAxrVMireJxe?=
 =?us-ascii?Q?zgrzh1rjzAnP8UsYdeuYyT/D5IuLTRbThg4S4HYuVoOMHPHJdnJ9XN/namYj?=
 =?us-ascii?Q?ucwcRarQ624COj9mNA/w40cSKZsw3zY8hGjDmuIf74ltwwfYT9vZTq4DVn3g?=
 =?us-ascii?Q?FUywWD8It7WqE0eWC2NVCAA9Ju62mpRse7zbqYNtUi5KugAv2oEtl4jdOdYH?=
 =?us-ascii?Q?+aRkyO7/Td2DFThZg1aVdrFk7lfVNMnbDj2LypXQhSdtcwy4uSGA5HGk5/sV?=
 =?us-ascii?Q?OakQamhm8WYsXVnkspgkII4AuNLO5gcMJtck8GFqsFNVJGvmKuS8DjqmXJbY?=
 =?us-ascii?Q?czNwzf/q1OVhYo9nkk6LKUZCE7SlvP9Rf2pJdmN3Mq7HOgZWw9CxN8KB1nZc?=
 =?us-ascii?Q?All5HUqQX9/NQaddPOvel7d1DntH6JyeFBfwb1eQTc65YHRzglrHaY7iB4pk?=
 =?us-ascii?Q?0YR+Et/s1b4/nf2/VWiPOtG+DPio4XfYm7MkflBtvboY9pfFFYF98dnDYRqD?=
 =?us-ascii?Q?nZxHGU2B457lA7CEQ4v2eXgl1k5k9oF65PKQYwiAhQiZjsiXBXajlop3Rgvo?=
 =?us-ascii?Q?F1hspPuOEA7SWqhc0+kwWuL5WG1fzTCTvSALWkrp0JmuzkOqa7CGMl7xrQp6?=
 =?us-ascii?Q?BoGXTooLoIT3CEfwOJiRAKhHjzP31frkzODlXTuY50mw3nLyJy6faEc1e92a?=
 =?us-ascii?Q?VYMSkifnBo/iZiSgrdlGJjU0RHSJP1u/yJwGy3qSFm2bhtLyXeEWnffVN/P2?=
 =?us-ascii?Q?xbDfIuNmEZQtCtrSpnyM2Mxb43Q+EmxWpgLFlPEPOH8uNNO1Q2iDgZ4x1woi?=
 =?us-ascii?Q?5rwx2zMOhbiyNub5P4Tzv1a+cnp9c6gLeZF1cZchY3bPhVWR+DeQINdzn5+1?=
 =?us-ascii?Q?+8wZPVtUdfggb4nGNmoQnEwdWutnL/1eC9eQT/BPMoxup1Fm/xJn6I6gjkgu?=
 =?us-ascii?Q?8PGkEMzuyT8vyQfjMhywWDFyNTtTPA6dfVUGir4WrnI9eoajhdfUPw9c+FGE?=
 =?us-ascii?Q?sWzj2MWhBnxNPdVC/hhdngFyVk0AEDJJMWYX7j27YgV4m1qa0cc6FDpPVN6L?=
 =?us-ascii?Q?HwTRVhqb/qpcTHdusLfHt+Izdk79Sz2IvHzAUBsIjrM8RiVsZYisaQhxPuOo?=
 =?us-ascii?Q?p9ufVc23axjWKbc373U=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(14060799003)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 09:09:36.1822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 309ad025-ba67-42b4-c9e9-08de3e152a97
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10507

Hi David,

> > Current linear_map_split_to_ptes() allocate the pagetable
> > while split linear mapping to ptes by stop_machine() with GFP_ATOMIC.
> >
> > This is fine for non-PREEMPR_RT case.
> > However It's a problem in PREEMPR_RT case since
> > generic memory allocation/free APIs (e.x) pgtable_alloc(), __get_free_pages and etc
> > couldn't be called in non-preemptible context except _nolock() APIs
> > since generic memory allocation/free APIs are *sleepable* for using *spin_lock()*
> >
> > IOW, calling a pgtable_alloc() even with GFP_ATOMIC
> > doesn't allow in __linear_map_split_to_pte() executed by stopper thread
> > where preemption is disabled in PREEMPR_RT.
> >
> > To address this, divide linear_map_maybe_split_ptes:
> >    - collect number of pages to require for spliting.
>
> COLLECT step
>
> >    - allocate the required number of pages for spliting.
>
> PREALLOC step
>
> >    - with pre-allocate page, split the linear map.
>
> SPLIT step
>
> The steps you have below are confusing :)
>
> > +enum split_modes {
>
> Is it a "mode" or a "step" ?
>
> enum split_step {
> 	SPLIT_STEP_COLLECT,
> 	...
> };
>
>
> But reading the code below I am lost how these modes apply here.
>
> I guess what you mean is something like
>
> enum split_mode {
> 	SPLIT_MODE_ALLOC, /* ... from the buddy. */
> 	SPLIT_MODE_PREALLOCATED, /* ... from preallocated buffer. */
> 	SPLIT_MODE_COLLECT, /* collect required page tables. */
> };

Sorry for *bad* naming from me.
Yes. your suggestion is much clearer. I'll change with this.

>
> But why is SPLIT_MODE_ALLOC vs. SPLIT_MODE_PREALLOCATED required?
>
> Can't we just test if there is something in the preallocated buffer, and if
> not, simply allocate?
>
> IOW, all you need is "collect vs. alloc", and the buffer information tells
> you how to allocate.

Agree. since it already check the "number of pgtable" before allocation
in linear_map_split_to_ptes(), That's would be better.

>
> > +	SPLIT_ALLOC,
> > +	SPLIT_PREALLOC,
> > +	SPLIT_COLLECT,
> > +};
> > -	pa = page_to_phys(ptdesc_page(ptdesc));
> > +struct split_args {
> > +	enum split_modes mode;
> > +	union {
> > +		struct {
> > +			unsigned long nr;
> > +			unsigned long i;
> > +			struct page **pages;
> > +		};
> > +		gfp_t gfp;
> > +	};
> > +};
> > +static __always_inline void __pgd_pgtable_init(struct mm_struct *mm,
> > +					       struct ptdesc *ptdesc,
> > +					       enum pgtable_type pgtable_type)
> > +{
> >   	switch (pgtable_type) {
> >   	case TABLE_PTE:
> >   		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
> > @@ -554,19 +564,56 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> >   		break;
> >   	}
> > +}
> > +
> > +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> > +				       enum pgtable_type pgtable_type)
> > +{
> > +	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> > +	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> > +	phys_addr_t pa;
> > +
> > +	if (!ptdesc)
> > +		return INVALID_PHYS_ADDR;
> > +
> > +	pa = page_to_phys(ptdesc_page(ptdesc));
> > +
> > +	__pgd_pgtable_init(mm, ptdesc, pgtable_type);
> > +
> >   	return pa;
> >   }
> > +static phys_addr_t __pgd_pgtable_prealloc(struct mm_struct *mm,
> > +					  struct split_args *split_args,
> > +					  enum pgtable_type pgtable_type)
>
> The function is called "_prealloc" but actually it simply grabs a
> preallocated page. Confusing.
>
>
> Should this function be called something like
> "__pgd_pgtable_get_preallocated()". Not sure.

Sorry to make a confuse. I think this name would be better.
I'll fix.


> > +{
> > +	struct page *page;
> > +
> > +	BUG_ON(split_args->i >= split_args->nr);
>
> No BUG_ON().

Okay. as keep only two mode:
    - COLLECT
    - ALLOC

I'll remove this.

> > +
> > +	page = split_args->pages[split_args->i++];
> > +	if (!page)
> > +		return INVALID_PHYS_ADDR;
> > +
> > +	__pgd_pgtable_init(mm, page_ptdesc(page), pgtable_type);
> > +
> > +	return page_to_phys(page);
> > +}
> > +
> >   static phys_addr_t
> > -pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
> > +pgd_pgtable_alloc_split(enum pgtable_type pgtable_type,
> > +		        struct split_args *split_args)
> >   {
> > -	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
> > +	if (split_args->mode == SPLIT_ALLOC)
> > +		return __pgd_pgtable_alloc(&init_mm, split_args->gfp, pgtable_type);
> > +
> > +	return __pgd_pgtable_prealloc(&init_mm, split_args, pgtable_type);
> >   }
> >   static phys_addr_t __maybe_unused
> >   pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> >   {
> > -	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
> > +	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
> >   }
> >   static phys_addr_t
> > @@ -584,7 +631,9 @@ static void split_contpte(pte_t *ptep)
> >   		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
> >   }
> > -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> > +static int split_pmd(pmd_t *pmdp, pmd_t pmd,
> > +		     struct split_args *split_args,
> > +		     bool to_cont)
> >   {
> >   	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
> >   	unsigned long pfn = pmd_pfn(pmd);
> > @@ -593,7 +642,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> >   	pte_t *ptep;
> >   	int i;
> > -	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
> > +	pte_phys = pgd_pgtable_alloc_split(TABLE_PTE, split_args);
> >   	if (pte_phys == INVALID_PHYS_ADDR)
> >   		return -ENOMEM;
> >   	ptep = (pte_t *)phys_to_virt(pte_phys);
> > @@ -628,7 +677,9 @@ static void split_contpmd(pmd_t *pmdp)
> >   		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
> >   }
> > -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> > +static int split_pud(pud_t *pudp, pud_t pud,
> > +		    struct split_args *split_args,
> > +		    bool to_cont)
> >   {
> >   	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
> >   	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> > @@ -638,7 +689,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> >   	pmd_t *pmdp;
> >   	int i;
> > -	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
> > +	pmd_phys = pgd_pgtable_alloc_split(TABLE_PMD, split_args);
> >   	if (pmd_phys == INVALID_PHYS_ADDR)
> >   		return -ENOMEM;
> >   	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> > @@ -672,6 +723,10 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
> >   	pmd_t *pmdp, pmd;
> >   	pte_t *ptep, pte;
> >   	int ret = 0;
> > +	struct split_args split_args = {
> > +		.mode = SPLIT_ALLOC,
> > +		.gfp = GFP_PGTABLE_KERNEL,
> > +	};
> >   	/*
> >   	 * PGD: If addr is PGD aligned then addr already describes a leaf
> > @@ -707,7 +762,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
> >   	if (!pud_present(pud))
> >   		goto out;
> >   	if (pud_leaf(pud)) {
> > -		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
> > +		ret = split_pud(pudp, pud, &split_args, true);
> >   		if (ret)
> >   			goto out;
> >   	}
> > @@ -732,7 +787,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
> >   		 */
> >   		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
> >   			goto out;
> > -		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
> > +		ret = split_pmd(pmdp, pmd, &split_args, true);
> >   		if (ret)
> >   			goto out;
> >   	}
> > @@ -831,12 +886,17 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> >   static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> >   				   unsigned long next, struct mm_walk *walk)
> >   {
> > -	gfp_t gfp = *(gfp_t *)walk->private;
> > +	struct split_args *split_args = (struct split_args *)walk->private;
> >   	pud_t pud = pudp_get(pudp);
> >   	int ret = 0;
> > -	if (pud_leaf(pud))
> > -		ret = split_pud(pudp, pud, gfp, false);
> > +	if (!pud_leaf(pud))
> > +		return 0;
> > +
> > +	if (split_args->mode == SPLIT_COLLECT)
> > +		split_args->nr++;
> > +	else
> > +		ret = split_pud(pudp, pud, split_args, false);
> >   	return ret;
> >   }
> > @@ -844,22 +904,29 @@ static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> >   static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
> >   				   unsigned long next, struct mm_walk *walk)
> >   {
> > -	gfp_t gfp = *(gfp_t *)walk->private;
> > +	struct split_args *split_args = (struct split_args *)walk->private;
> >   	pmd_t pmd = pmdp_get(pmdp);
> > -	int ret = 0;
> > +	int ret;
> > -	if (pmd_leaf(pmd)) {
> > -		if (pmd_cont(pmd))
> > -			split_contpmd(pmdp);
> > -		ret = split_pmd(pmdp, pmd, gfp, false);
> > +	if (!pmd_leaf(pmd))
> > +		return 0;
> > -		/*
> > -		 * We have split the pmd directly to ptes so there is no need to
> > -		 * visit each pte to check if they are contpte.
> > -		 */
> > -		walk->action = ACTION_CONTINUE;
> > +	if (split_args->mode == SPLIT_COLLECT) {
> > +		split_args->nr++;
> > +		return 0;
> >   	}
> > +	if (pmd_cont(pmd))
> > +		split_contpmd(pmdp);
> > +	ret = split_pmd(pmdp, pmd, split_args, false);
> > +
> > +	/*
> > +	 * We have split the pmd directly to ptes so there is no need to
> > +	 * visit each pte to check if they are contpte.
> > +	 */
> > +	walk->action = ACTION_CONTINUE;
> > +
> > +
> >   	return ret;
> >   }
> > @@ -880,13 +947,15 @@ static const struct mm_walk_ops split_to_ptes_ops = {
> >   	.pte_entry	= split_to_ptes_pte_entry,
> >   };
> > -static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
> > +static int range_split_to_ptes(unsigned long start, unsigned long end,
> > +		 	       struct split_args *split_args)
> >   {
> >   	int ret;
> >   	arch_enter_lazy_mmu_mode();
> >   	ret = walk_kernel_page_table_range_lockless(start, end,
> > -					&split_to_ptes_ops, NULL, &gfp);
> > +						    &split_to_ptes_ops, NULL,
> > +						    split_args);
> >   	arch_leave_lazy_mmu_mode();
> >   	return ret;
> > @@ -903,7 +972,7 @@ static void __init init_idmap_kpti_bbml2_flag(void)
> >   	smp_mb();
> >   }
> > -static int __init linear_map_split_to_ptes(void *__unused)
> > +static int __init linear_map_split_to_ptes(void *data)
> >   {
> >   	/*
> >   	 * Repainting the linear map must be done by CPU0 (the boot CPU) because
> > @@ -911,6 +980,7 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >   	 * be held in a waiting area with the idmap active.
> >   	 */
> >   	if (!smp_processor_id()) {
> > +		struct split_args *split_args = data;
> >   		unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> >   		unsigned long lend = PAGE_END;
> >   		unsigned long kstart = (unsigned long)lm_alias(_stext);
> > @@ -928,12 +998,13 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >   		 * PTE. The kernel alias remains static throughout runtime so
> >   		 * can continue to be safely mapped with large mappings.
> >   		 */
> > -		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
> > +		ret = range_split_to_ptes(lstart, lend, split_args);
> >   		if (!ret)
> > -			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
> > +			ret = range_split_to_ptes(kstart, kend, split_args);
> >   		if (ret)
> >   			panic("Failed to split linear map\n");
> > -		flush_tlb_kernel_range(lstart, lend);
> > +		if (split_args->mode != SPLIT_COLLECT)
> > +			flush_tlb_kernel_range(lstart, lend);
> >   		/*
> >   		 * Relies on dsb in flush_tlb_kernel_range() to avoid reordering
> > @@ -963,10 +1034,61 @@ static int __init linear_map_split_to_ptes(void *__unused)
> >   void __init linear_map_maybe_split_to_ptes(void)
> >   {
> > -	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()) {
> > -		init_idmap_kpti_bbml2_flag();
> > -		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
> > +	struct page **pages = NULL;
> > +	struct split_args split_args;
> > +	int order;
> > +	int nr_populated;
> > +	int err;
> > +
> > +	if (!linear_map_requires_bbml2 || system_supports_bbml2_noabort())
> > +		return;
> > +
> > +	/*
> > +	 * Phase 1: Collect required extra pages to split.
> > +	 */
> > +	split_args.mode = SPLIT_COLLECT;
> > +	split_args.nr = 0;
> > +
> > +	init_idmap_kpti_bbml2_flag();
> > +	stop_machine(linear_map_split_to_ptes, &split_args, cpu_online_mask);
> > +
> > +	/*
> > +	 * Phase 2: Allocate necessary pages to split.
> > +	 */
> > +	if (split_args.nr == 0) {
> > +		err = 0;
> > +		split_args.mode = SPLIT_ALLOC;
> > +	} else {
> > +		err = -ENOMEM;
> > +		order = order_base_2(PAGE_ALIGN(split_args.nr *
> > +					sizeof(struct page *)) >> PAGE_SHIFT);
> > +
> > +		pages = (struct page **)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> > +		if (!pages)
> > +			goto error;
> > +
> > +		nr_populated = alloc_pages_bulk(GFP_ATOMIC | __GFP_ZERO, split_args.nr, pages);
> > +		if (nr_populated < split_args.nr)
> > +			goto error;
>
> That is prone to cause trouble in the future once we allocate memdescs
> separately.
>
> Can we simply call pagetable_alloc() in a loop here instead for the time
> being? A future-proof bulk allocation can be done later separately.

I miss the future plan.
Yes, I'll change to pagetable_alloc().

Thanks!

--
Sincerely,
Yeoreum Yun
