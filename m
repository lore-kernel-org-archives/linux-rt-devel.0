Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6F2951C9
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Jul 2025 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570034; cv=fail; b=EsmUOh1mhIPNWwb6aAKLqxn3N5nIukiwubF7HASkh6WJrUq9VYSDbpOrycDtqHvF7QgJE4tqUAuK/IoY1gZUYYofTcVuy7S9yUV1yeregiOyyA9dcLYgl+ONbss3+4jvPGvIT1CtvC/13Tv5Fg/YsidqTVWG+C5roHKtNgGjGZ4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570034; c=relaxed/simple;
	bh=LSyDSBYcYQtK/8MI27V/aG3vD1Kg/PELeyMWpkFhL8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cgnv99bauwAkhgEq28voq2WXsfadhHFJS8sihttwa5QHIzU3rL3mQPKDBPW5gvLcRi0QuO8mfOuy3JIom8wxqWBj4/A/iVU3PAbGpobppNphLY3pkkCefRTJOd5No8xkrVWAhpwJ6l5fjrraE8sHmAP5oNKSWaflJzHHu6FJDns=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=atCnQyNa; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=atCnQyNa; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="atCnQyNa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="atCnQyNa"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DA1uvufoQxtGhiIc/IEUYEWIGtTZCu8rqTZJlCLSarLQmHAkMbOz2is7CpGwQPC+EQ7kRLhAzOQ0+4PWK6xxswUbPQXa+CfMBVy4G2nsxtjPwHxG4T4C8cxLC7w4zwsQN74g/on5q5Eul3MzXWljYIpSYWxp/NvmkjbNhrdvi0A/MWpZjlfEVooTfVfQQONxNGazmyObXE5VKIc2cgN2/iI32ko3n3F9dZxu6W4cAZMhT3s8fLerZHVHhuKIiWVbB62qYKzyW3vpKE3bQ3Fz0uIdXVJ6Dhhj7En5EhRFxt4FOgIKTgQYLlIPUOV4bpA4spGc1vbqNAm5WCzDUDyILA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0sOspPCZI0ROLFeFkyrpTd/6rokrHAH7S/twcOb0Ck=;
 b=ki8LxLJ3Zh4iDBugnWIKe2lbiEXcLYBfdefui/kDWqn04BsPrqxnP7YHcijL8XC9CZTLRT6VrM0vaBmzo6geOcKWLzt9DK9R4bnmTxZpQv+xCwJ1cCmfnOky2a76CwHpY2KM7IRbbhhV5UaPLkHHJIDYYpt9Qk2ynzFNFaXfKLjk1J/9K2oNuorTDTwHNwR/BUFwjL5hXN0vBboDk9qySeZCNFkGHp9S1nqsZj2NBB/BNZ/6tlwwKoe0BRM6GHo5bRb4wFvDZE9L/1RS02zGMZl2dkO7pTQ+817wTPqdYQpPNO5OlzJZEzy5vr59zybXdKryb1ajjA80RRURbBuRfw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0sOspPCZI0ROLFeFkyrpTd/6rokrHAH7S/twcOb0Ck=;
 b=atCnQyNaycngE0GkMP/mNvwk9qoiYzdcR+TntzzSGLrFHnO6gb+kVL0QU/ZreLOnz95t5FxVmtTArcrbEci2wFrn+VR1SyALYC0mEW+AkbHXt+q+mfcXf7BzPFEnyyKnZ2dDN5QSwWnOpzMWvArIJcFPBjFlNOFrRcNtQHTpzLQ=
Received: from DB3PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:8:1::25) by
 AS8PR08MB9905.eurprd08.prod.outlook.com (2603:10a6:20b:565::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 19:13:48 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::43) by DB3PR06CA0012.outlook.office365.com
 (2603:10a6:8:1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 19:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Thu, 3 Jul 2025 19:13:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOlXuJYn7pydu8fDoOh92bjDDrlsgWH5zQdq+W6sujdyOGLjhdyqoJ6zYLXpIJEqRiUHESrexEdxwK/g/BX3eXASyolIbkvPGczpZSYSevS1pMViPqq6roSpyY36WwoiassQGk1m8O5QkvTE8x59nTK8Xw+u1qrfECuEneRFmKxTg02u7RC5WmawjOwVVIVRQYuT7HHoum+CaaTBpJsh15Gc7ew1TYcs46AVo2ucUhNY1jnHtCIGiGoiVz242qrOwMnx4eImiz2/wxnSdkMeaZUqukhaan9Xv9ivYfJDYHBsAH+99ASKYW+4UJVI2DYqzed4IfIRTZ98ibhErZDB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0sOspPCZI0ROLFeFkyrpTd/6rokrHAH7S/twcOb0Ck=;
 b=IYDK/I0dzREWUphq2jn0cVn3F4hkHoJkzxKnQkHQ/WEw1TjTS00gnvpenZ+28Dhxy2YyVs8B/44fcKgBY9FRhpzzP4Vl9cJYaHAqOpOOGuVMXCQX/458Q+ZBlyPIJReefth+ctFBPkrF+vr5z6wvoLRgPZwoXPZB3mXQFhM/Al+CHdTUkB5o3FZ95x2l0imXXeZhGx5R4VTg4VfzBS6TjM4/pRGHDefsYxowsKCKskRdgu2LAKB4zQZQxb8N1ctGv5SwhzDKrLbo+H+Wc0wxXhH99IBPyV8gbBIdNOZqm3kj5UeDBm+30uKK2jVfTwn6YQAPlbveNkLhEj+RN+Kr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0sOspPCZI0ROLFeFkyrpTd/6rokrHAH7S/twcOb0Ck=;
 b=atCnQyNaycngE0GkMP/mNvwk9qoiYzdcR+TntzzSGLrFHnO6gb+kVL0QU/ZreLOnz95t5FxVmtTArcrbEci2wFrn+VR1SyALYC0mEW+AkbHXt+q+mfcXf7BzPFEnyyKnZ2dDN5QSwWnOpzMWvArIJcFPBjFlNOFrRcNtQHTpzLQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB9PR08MB7557.eurprd08.prod.outlook.com
 (2603:10a6:10:304::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 19:13:15 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 19:13:14 +0000
Date: Thu, 3 Jul 2025 20:13:11 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, byungchul@sk.com,
	max.byungchul.park@gmail.com, ysk@kzalloc.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <aGbWR+Q8XHtpdc8P@e129823.arm.com>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZeL4KQJYg=yozG7Tr9JA=d+pMFHag_dkPUT=06khjz4xA@mail.gmail.com>
 <aGbSCG2B6464Lfz7@e129823.arm.com>
 <CA+fCnZfq570HfXpS1LLUVm0sHXW+rpkSOMLVzafZ2q_ogha47g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZfq570HfXpS1LLUVm0sHXW+rpkSOMLVzafZ2q_ogha47g@mail.gmail.com>
X-ClientProxiedBy: LO3P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB9PR08MB7557:EE_|DU6PEPF0000A7E4:EE_|AS8PR08MB9905:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f66b24-01c6-444e-4797-08ddba65bd0f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Ad0/LpFCRHKhs89PZHxxlYSD/8MScxFPm2fR932ncrkavc8XuGv8Ug6TMYC6?=
 =?us-ascii?Q?j5YfIhse/T4YD6HWGT0EDsgnMuzoOJ/JERF3YAKZ58Th3y88qtm6b27wXok/?=
 =?us-ascii?Q?GRCiuXQgBseWbDm5ri+AECr1bfhD0LvKjwnXn1KT7kTUzOxU6G5AONvR/vIa?=
 =?us-ascii?Q?ufDgqStPN/RkvAz/Km5FBJL8x4Az2MUdCzgDjZaq6HjMfnS/JavY/BtbK1UM?=
 =?us-ascii?Q?fV8GxDWptYGbi1ylKCGVtH7D0J80ilJ06PEtCUk/zWRB+roK+bpXuP+bhFL0?=
 =?us-ascii?Q?HVzpccVWISZWg6wqzDykvXkKBQ3CaWmSR7OBZyyReHAvKdNyjeK+JgzStto1?=
 =?us-ascii?Q?WfGd5vlfjR2DFTMJ05vGEnlvW2pEMOkQqkDuizLE7xm/FAxC99SXp62vLlsn?=
 =?us-ascii?Q?NXbJJQk9oWXsyxiakv+4t56oCTo/kb+jxIHIh7zh7AABnmf1QN7yE6eti2e1?=
 =?us-ascii?Q?3YR2lgXEsf6tCEetxRoa+nBb6nDLIuStfR+6xrXWH6V9NCDuivPexlJErXzj?=
 =?us-ascii?Q?jWJ1YQSy4L10LmBS4IGBCRbf7HYZdFeKt0RLz5tXIRICTviDP9O855AeFCCM?=
 =?us-ascii?Q?YhYgk6wEnf19hQUjupR3Mib4yShv/Tm8eaCQp+luDTaRxIRfLPCbWaUB/1hy?=
 =?us-ascii?Q?k9x9BThUG4EBpgcuXfbkeKSoqNGPRe+iMO8mV+gPgzsyXb+Js/MMPfFc3KeZ?=
 =?us-ascii?Q?yqX+dJukYoAZUCnsLdNWhilGTD1GUadJ2GBnQlqSHIFPgwrnfxDS5+KAjZkJ?=
 =?us-ascii?Q?/JGBOxX32zTplznNVvhZxrzfkE2VhoNXYe90s1DqCWW+/KC0rwQa/Zp8sL3S?=
 =?us-ascii?Q?7PvyawTV7cNBqx5l5d4Bb8dtinLyQ2lZ+G+3bh+ueaEWUpd6fdyGi8AMrlgb?=
 =?us-ascii?Q?3H6PBM2NjA0YkgOttXTJwJDl//mniA0u1RiwBnAk+MA6x3bNzBj00ShU3jzX?=
 =?us-ascii?Q?UpePECvP8xrppMl53tqMJct+wNwzaprM8rXP61u0JumuA72yw1/zogYUftXB?=
 =?us-ascii?Q?yjufOCNpzGHZ+5VwLUcCYJHur8TNo/UaSfKSnY/i2wP/FnVX8pkBWTkZ/dxM?=
 =?us-ascii?Q?jClYd/S2wqS+H7XwRAYICFblXRXKlna0zXhCHeb7lvXGPPDDPlgwRmzHPkrZ?=
 =?us-ascii?Q?GcdBX4Ql9CiiWzBF8qmVM1AN+XC3AMjo4oPNI0fKJWXFTmP6TQpBDHPdYDK9?=
 =?us-ascii?Q?EM6c6T0Tm7eqUHwa7maKbx+RqaFLvl2ab/MmGf4zwinWK8XSU7757+TEdNkh?=
 =?us-ascii?Q?HSoOw/CDLpwXdeownj88tp3NhXSa6UGdEqkgcENiphBynctTegipv4AvDCWn?=
 =?us-ascii?Q?G4MfEwJXX7RWviEa47BdM6VSkAwxHuUXF5tCdQoeyKcHM15WKB0vk/xhov+e?=
 =?us-ascii?Q?Srdyic2KYCQlWHZjdUzVOnn6hBcWhn3UtNZydURd0XzUXVY1d8vE8aDS2v8o?=
 =?us-ascii?Q?4YTpo5ENkD8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7557
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c54d4424-9172-4258-88f7-08ddba65a8f0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700013|14060799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BBLztpCKyGUG5lzUY2HRbFHz6MD8fwzqFN+Vcnr5AADFOLXViW/w3zbgjLj9?=
 =?us-ascii?Q?655uwqqKso8XNT8MRwvuhI+5OSdzyD4TNu3DNt1fxLjR0aptW7vL4yxtXBVW?=
 =?us-ascii?Q?++r7HrSmf+dbY3qS474BQAqRRUINsQOPIwSas5o/+qZxj9y2ZvYGCV/1OGtm?=
 =?us-ascii?Q?4OH3xkTJYAS9lHGNCwGt082oeVzPhDbRkf+u0CtJbMCdr0gSl2utd96tgntz?=
 =?us-ascii?Q?nHJ2LQ4CKYkboLwjw/ysw6V/bmE4XuXMzR1HdGLLL9gf3PqCwLnmtM8Whd8F?=
 =?us-ascii?Q?/yt1VThxZ48RSIKGXoZVzRVKODcZ4etjYJB3jLT/FzEXcOjqndFrxrgBiqD4?=
 =?us-ascii?Q?J+JzMZBqW9sH0QnImhj1+oOMRJ3Omkt1ZNlaBMCdP/jk+V+MNpAZ/dbXPHTc?=
 =?us-ascii?Q?W2dWG/2EGoz4qaGvgysVLhxercFjs+jm8oZKWIVkvcbh2v7nWE2ssTWL02kO?=
 =?us-ascii?Q?ZS2gRm8ETUFDhhR+s46j7deQnRzj0myMgTwoj+yHj7cud1oZ7b0OQNFPUNAm?=
 =?us-ascii?Q?/WyiNwSfmFbvkdJqG2H8NOgPfOy4/6F4282It9vZIaHZa524TOJATHkWr1F+?=
 =?us-ascii?Q?9i75K2phSsRilKe3AScEFwACGE4voUhooE75WhG6hb3AnSDzXH7TEceQgOEE?=
 =?us-ascii?Q?90cjpkUyV5lDG8YzLStbAIoZ8eUHBZ2LiLvDqSzuTM+j/cHmIh+xrGlzdqtl?=
 =?us-ascii?Q?evNsWYQ0rpdFGSwxHzxOfoLpiPtJX7uY/Wdo4rXLJa4mQrI68LScrMhPzG4i?=
 =?us-ascii?Q?NxiLpMspu1gyHLsgFhOp2PCsvumNlu0ecwJcMEQ8ShuxS/QlnHZbiz/12zsL?=
 =?us-ascii?Q?J0aSqOrQjmBAlSFZBH5PCKWNnWk5MxGetVqFkMOwoN6OGwisWJw+GUL4AhyG?=
 =?us-ascii?Q?Tt7sLp2jSbA1KG+6PlQabuTnvu26tC5Qjrd0ZT1KASGeMNXcPBmx8c0UWyPU?=
 =?us-ascii?Q?jBZKMHMxHV2OwYfEe2lgZ8vs3Q7E5al2E3GzCYbs8lvOozb6Pz2lVlSs15ts?=
 =?us-ascii?Q?sVXZJiwmNbgT28F59rduGw0xSvgx/079OnzC3E+4VhVydimDU1veWZVHbplH?=
 =?us-ascii?Q?cC3Lr3izI+/lVtKo4CjV0YVx0iJYHaElweovdujcpKUFgPms/r9GWWpNAKBY?=
 =?us-ascii?Q?QZNpZJFd9dCPOI5OGgwtHQn5w61fex2wpsbN5bcradvNtek9infCKzTp8Exw?=
 =?us-ascii?Q?kEKPiV5Lt/ipMSU5cbZP1qaQ/Uw4AV3I+9LhyOU/i5vVPVrnQ6wq9LQGK3HP?=
 =?us-ascii?Q?MQqNyveslXxOvGuk+CU8A+YQhQ8XhTLg6h8a0GZtwbEgW5p3Q5i8YbEipsDD?=
 =?us-ascii?Q?Kn9RU4EoYw43RKhFIZui6G4qYZoTONbgTJUQc5Y95hHRc4YKU86JU3zVVT8z?=
 =?us-ascii?Q?qNDBuqXN7+U1PI9lKLDBa4YrVtTm3a9WSuWmigrYoGB/eJ44xotpsthfDatL?=
 =?us-ascii?Q?vNJI0tj0jQNXv1P2KbLFsAzOGT2vtfYKtqXpxn3+3J2Uon4iGjLLP3WWGw82?=
 =?us-ascii?Q?ihiBPIF1anuzQVvAJMkYVvnwNn4qAEIiViYvKtg+zBWj7C/wkA3EPMHRrQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700013)(14060799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 19:13:48.1871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f66b24-01c6-444e-4797-08ddba65bd0f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9905

Hi Andrey,

> > > > find_vm_area() couldn't be called in atomic_context.
> > > > If find_vm_area() is called to reports vm area information,
> > > > kasan can trigger deadlock like:
> > > >
> > > > CPU0                                CPU1
> > > > vmalloc();
> > > >  alloc_vmap_area();
> > > >   spin_lock(&vn->busy.lock)
> > > >                                     spin_lock_bh(&some_lock);
> > > >    <interrupt occurs>
> > > >    <in softirq>
> > > >    spin_lock(&some_lock);
> > > >                                     <access invalid address>
> > > >                                     kasan_report();
> > > >                                      print_report();
> > > >                                       print_address_description();
> > > >                                        kasan_find_vm_area();
> > > >                                         find_vm_area();
> > > >                                          spin_lock(&vn->busy.lock) // deadlock!
> > > >
> > > > To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
> > >
> > > Can we keep it for when we are in_task()?
> >
> > We couldn't do. since when kasan_find_vm_area() is called,
> > the report_lock is grabbed with irq disabled.
> >
> > Please check discuss with Andrey Ryabinin:
> >   https://lore.kernel.org/all/4599f645-f79c-4cce-b686-494428bb9e2a@gmail.com/
>
> That was about checking for !in_interrupt(), but I believe checking
> for in_task() is different? But I'm not an expert on these checks.

I think below secnario can explain why we couldn't use in_task().

CPU0                                CPU1
vmalloc();
  alloc_vmap_area();
  spin_lock(&vn->busy.lock)
                                     spin_lock_irqsaved(&some_lock);
    <interrupt occurs>
   <in softirq>
    spin_lock(&some_lock);
                                     <access invalid address>
                                     kasan_report();
                                      print_report();
                                       print_address_description();
                                        kasan_find_vm_area();
                                         find_vm_area();
                                          spin_lock(&vn->busy.lock) // deadlock!

If you call in_task() in CPU1 before calling find_vm_area(),
it returns true and try to call find_vm_area() so it still makes a
deadlock situation.

Thanks

--
Sincerely,
Yeoreum Yun
