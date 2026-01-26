Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691B341AC7
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445055; cv=fail; b=RxTJbiWppPFnyYWPkofVuXfC0EEYYJUijEeKaH+wHK0N1ACgMPxTesudeTQabdtpS5PzWpDKVnLfGviCembBCydEZIu32gkrCYKkr+tV9x6iBEsoYu8mnrFJa9JblfPdVefu1i720aEy08erEZImDd4hkjsTIyVNyDKKX3GfnSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445055; c=relaxed/simple;
	bh=GCRn3X9UaPAXTNCFGZkkw0XjH2YdvHNKjl8dTs03AGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qi+//lD1lbV5Oa7utuHfQMCOJJvnxvE4VyiqvBrFHzL9eJC25S4Vy0jUZPY/smFvGBehiW2j18+lwf7O6RWJnAVJuC4TV+m45R+H5GdI9G7NR2gynE665glGMdVRdfx/0E7rR6lI+yVCi+ltAWIo16pC/OqNPmUqbcrtoR5yvkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NlfBdA30; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pMPzRZAg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NlfBdA30";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pMPzRZAg"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q4fGXJ284015;
	Mon, 26 Jan 2026 16:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=riho9L21aHubqxSl4c
	pvyFF+/bl7BpeJqzByM787hmw=; b=NlfBdA301a6ZUgaHY/0Nqw9CIeKKfJsJfZ
	BmWhl68/6xXHZ84+JRXWkSEXiwjWx6Mfl82Do/0u3w7PW8FNm4DUdQM9tK3khFCO
	Xr/BkqOz2006TFiveBY2XB6wPkqwRxJEgoAHv1LbO1VZsvYaLDJ400wYcQelsNx1
	DifKJvUfj3SQf4eLTlbuBCtSCwXKVivCGxBYi5N5VdQR1SHYVW0+okgL9H/kxOhi
	+blGK5TnhlDBai9nZhLPV6Ce9Ip+cyVuBXN6hrIGQY4b9qeTa+g4p40IQb/qi6k3
	xTPB7ehrj6wkOcsgFHxVDQzHNxVO/iI+x8LwLmTOkDbTRE7QDGHg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny27ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 16:30:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QF04to012749;
	Mon, 26 Jan 2026 16:30:23 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh8611u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 16:30:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VL5oonulEj/BV61UEuHrimWwbaV8T75/7QJeDL4Q2ksI7DcauBFrSUHhlafRBsBt18HbLUzebL1fByCfxbFtrLJ0rLnLNBOPVvQWSOySkqqg8ad1GHAjhlUF7nwLtOKdXR30eOzfew/DYTxokX6OxD1gquSM4ggHg2Of0B1Lz66SCACpS9tGRMqsfY65Ej138Ap66RSdPaA+5wf9ofZofBBpx9HJJyKtkWfhPwbiMPYjYBWDNIdm3HVAIHmyzjjeIJBddDAHu2A2kccwjsQ27vf6aP9xNoTIHsaVTHK1b6Nb+qhpGNkMtug9O3LX8HW9a2rWQ/YeH73FAoLNlc1YDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riho9L21aHubqxSl4cpvyFF+/bl7BpeJqzByM787hmw=;
 b=avJZ/FHoRsgVkAOoczFSPxoeRfDUDerQfDZ58FD1IME5dmSivefA627ufsNup1Ux+HHrve4VHX5AUVyHVJ+v6XrnXmvvyd3vLTCbeFoeyxr4aLhBxQlCbSu67nfNEnVoXVVDacE09r6ojIGybDba1Qtq1P+U/ocly4bneTRd3TGc7W+oQ1Wl0aP+j2jHHhystiR7u3yi4fOFUoLekkFA7KKmKLjrRvrgwM82MT/BP+ejXFlFHRK8Js+bP5sODx5SGg0OHB7KOoG+bQWikN8UYZLqOaEZmLFic3ugdt+1NE8EPgpeVa9tgL4NQk9E3J3CEQWxuHUUqwy2GYCrXNmpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riho9L21aHubqxSl4cpvyFF+/bl7BpeJqzByM787hmw=;
 b=pMPzRZAgQuDhpk2fPZAJs/wcFsjAhutOLuPsxKDzYzBgRW/f1g2E/SVjrDVL5sK3I1G3yJEQDFry7N43wMVPFSvQJNhSY7WbCrPbHilcQWgNGp5qZoai522kQNRihSPE4LCKcK0twSXqJeaWHvzJlxIuFL6+Xwtui1SOvoPC0XU=
Received: from CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7)
 by DS0PR10MB7407.namprd10.prod.outlook.com (2603:10b6:8:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 16:30:10 +0000
Received: from CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9]) by CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9%6]) with mapi id 15.20.9499.005; Mon, 26 Jan 2026
 16:30:16 +0000
Date: Mon, 26 Jan 2026 16:30:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 08/10] mm/vma: improve and document
 __is_vma_write_locked()
Message-ID: <3fa89c13-232d-4eee-86cc-96caa75c2c67@lucifer.local>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
 <ef6c415c2d2c03f529dca124ccaed66bc2f60edc.1769198904.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6c415c2d2c03f529dca124ccaed66bc2f60edc.1769198904.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO6P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::18) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB8215:EE_|DS0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e2e358-da73-4626-cb9a-08de5cf82f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23xK2OwmOiVdMjjAZwKpJqLczMI83bGWo1R2msGB2XFsCTL/WTw5yKx5lSG/?=
 =?us-ascii?Q?tEvnevofiPbIB2HtZhwyh+89P6viaC4o+Yop9h7NZ4aeaQR8pD1cEIsX/lmR?=
 =?us-ascii?Q?4eo7zeE5rbWeYoQy5S83UOHyE0NqwlcMFRcZJ0/vt0JPrpLXvj3aMkFEiW3p?=
 =?us-ascii?Q?B7pQKuxz7sGCaNKvJDj8vyxwI/UsoVr8dO7egY0flRxd7Ia+rfoLePW5tJ93?=
 =?us-ascii?Q?QUrT2NwovuyaWqeO7yX/If+YfRhalOBwtiiFkVVLQqhi1YcATXRLoFxAj1Tc?=
 =?us-ascii?Q?hnDbkPMoPt+3+j0yH/n844nB9n/DWW/q684MUsrgkcm7N3k+AUOsRSX5clPP?=
 =?us-ascii?Q?F4kAgkBl9amHpp9i32WY2UREY4EJdWYuBZQgxTKTb6swrtKyf5ZGt6uZ0Ta/?=
 =?us-ascii?Q?DacZc2k30d2vCXs8y5PrW8KQhkcz/nbFiANl0a1KPN3cl/TIEt2Muf1Gja12?=
 =?us-ascii?Q?EmR+hLAx2mnt+OmpiJrKDfrjBCoL4Hef+wDv2cE1v/1yY5L8RYwaFqQ1+GvL?=
 =?us-ascii?Q?alNVqdMPeb5OyNYF4EWxv23zaWlu2bNX5fOjssm4vptUj0xxy9oBm7C9Aa2d?=
 =?us-ascii?Q?XIc/dmbIO/jemi9QXlGuT06qzpjsaX4JcuM2LDzVZEt4t0i58rzNhKZIRVt3?=
 =?us-ascii?Q?xD+1w9m+EKpcKU/01vAme6qT8cZNPqYsBIgtEEu6MLJrIhyV20w/s9q4zP4R?=
 =?us-ascii?Q?F9BGumAr6BYT+h4Kw2vv7fKkN0BKwaj2I7wG1N6WuGSFbb8UKbAB9r+OTJp7?=
 =?us-ascii?Q?y36bVZVXoqS34JP5WbuRu87mAks2d1+xXcWiMX1Qxh+1NdtF6/W4q0GQpHt+?=
 =?us-ascii?Q?S/04y/bscRstGn/qnWKpoQ30rpMM5d6h1/nGRp676U9THvRXdSovw06OG2Y9?=
 =?us-ascii?Q?kp3IPxtUQyi12YEzFOtmTDwWtg+5vJWYAfJGZggXNHFn2HZ4CPkU3V0VWC5D?=
 =?us-ascii?Q?/RZGttOPKSPcDwPhn4lC+LS6mvq7V0kmzaZ7mSoUjPMcpsHgwUhnVx1ebzpO?=
 =?us-ascii?Q?f31Phn5xGLRLty24138tMeGBX8xREezz9MsWz2oqml1BYf//FuP7Xp1XC059?=
 =?us-ascii?Q?8N976KVzgEy5AgXuhx12pDyWb57KtHyrFfUXBiD7T/nvZi7d+KHZHQ42uxoC?=
 =?us-ascii?Q?6L6iDKtHR7fd4B3K3Fg8omUbyzTXac7NAAHSTblGa4cMeUt9OWMdcN2o9Maq?=
 =?us-ascii?Q?6Vx8JYOg9H1EZ9cpcf2z50GAlCarvhv3oRLrzvhb/BXmUsnP56DGpCeIebeP?=
 =?us-ascii?Q?lsQ6ONVD9a08Gz222yGbdBmxVUKvlFn1Xx2ixxwVD+1sChjV4ADoiPrDFOBP?=
 =?us-ascii?Q?WDlBOOhc3t3bvUSPh0qkAbwQaHMJSqgNATvvxKPFnGvEMrwytqP0GDiMfEfL?=
 =?us-ascii?Q?/QtnTbGoDkKDvWAmiI6vNQON7ZWFXuDJJGlKyw3ZE0x8hMro9hJcDiP9oxrI?=
 =?us-ascii?Q?fCG6K9TVZT3cCSvpus8iGL3xA3H4yCp9eoEyOTOdGePH+Bue3bVLZxHISDvK?=
 =?us-ascii?Q?OxCZ9WrsuM6MtCPRiWKzZlKzU9SvsBIXYt65KXJwrZqW8bJVsjy/9oYppo4I?=
 =?us-ascii?Q?8sOz4OhiHCD1ZmjeEes=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB8215.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gBe8f8IE1phb28CPlXq91twcZWAp73HAtRbcEwEJ67BrsIwceIhfwcFlYk3k?=
 =?us-ascii?Q?THZ0xczd30wVEzHGDFqF0ocKDQXPEBlQBeMYxCQgy3QkXeAJg+AkOni0AoyQ?=
 =?us-ascii?Q?k1/KPKh52TI0LLp+fKMqg42FxewUpq4OFOOq7+bPpiYPk5ryKs7tyIEebvuU?=
 =?us-ascii?Q?xaaROF9lz/UdkKH2Yl6Qlyg1en3PiU8DSfw0Q9I1HVJiCzN2YGQgyKh7kNT8?=
 =?us-ascii?Q?vPUndgUchb7gnwUVrUwQ3YMcXAbbT83eHSxtuOlXok/kXQO6/Jatm90SzyJw?=
 =?us-ascii?Q?lTzhmkGoz9dBDij0dhQsjgaQLZC8QB2k0rsRXyA0xCI8A8ir+fxV7XmbBw42?=
 =?us-ascii?Q?npuRet7DDYN/iiIix59CoPcQTdUCxzdpeNpI/pL7rzWxpy5o5He+UjsrIRoC?=
 =?us-ascii?Q?etHXD65sEVgFyJLqbPMYFz+6r4FAoHHaG/AJYDYcILIEW+bh4DKngNibDmzn?=
 =?us-ascii?Q?J+JkR+WKJB2OLWcN/jA+aDS/+gXH7PLRU2oFLchaKBbPWqRWAFXlzds8ZvbC?=
 =?us-ascii?Q?c/Mfjz0sKASstWjKlw6C7khcnIJQwQ1Pp0NqgFCVAvtdo1EeoJGaHAC3rZBX?=
 =?us-ascii?Q?KxQjj/YmcuZIe29NZs9RiB66cl+T67cxgwSHNSdxyWLDKtIJNwa0MTADdip0?=
 =?us-ascii?Q?+CeDtXZyDw4U3P98HudGV2bsUDlK4tIrxKYJ3k80FP4t0NqsuyOluVBTZOe6?=
 =?us-ascii?Q?VwUyp10AaGZIPm2MIDNLwoUE9t1yMiV5i/pu9M3udNua7LmrXmGwFSDyJvT/?=
 =?us-ascii?Q?c7xGYuar5obtXUIrtzAQIqRemsXUmlYrNwM/pr84UPId3le2i2faz4FXaZWc?=
 =?us-ascii?Q?ufUAblTwUbPqcsiBrMrYelYTFOfjaJpOHOKTkrbUrHKudXfon5t/GN5kdphN?=
 =?us-ascii?Q?H3l8S5otz4AnpdBtp+zncouBPJEz/MUeJ0Tjrgo0ThJn9OhVu0wnP8F6faeo?=
 =?us-ascii?Q?mEhfYQBfZLioMXBUk7K1TbGm7NhWl0ljiGF5sx1cElCcfWdGZDgss2U4/63C?=
 =?us-ascii?Q?gQYN2OfKNeUeC+ucrjlE1ANLvNLP737xFLiC9nGQzjF1vNYB6HL2FDlEOF7X?=
 =?us-ascii?Q?k2TP6/9Ue2NIJIu3CaPrUuwP80HnvXjAm/+1Rf9LKcmG69+nespy0mHX4IKq?=
 =?us-ascii?Q?W78JYOBzJ2S4v2ENhJ3ulgYD3NcD0ZgUTJnRSPAPIWtKqFH6KJjA//mzAZP0?=
 =?us-ascii?Q?A9kqQF17SyRVArkRrdotiAo/FePBKrkpvkIiwPRL3tYhOZmjapax6tr5TkNt?=
 =?us-ascii?Q?eGwSU6RjAyUUSo/+Eqyfjf5KCOFPIViI7X1X51769Al0j/1hgJejJx1skf0Q?=
 =?us-ascii?Q?3giq9CyBiqxPMF9p++Z1D12945MR6MQ/uSGXm9OnOGtEupOpiB6amz5bZXVa?=
 =?us-ascii?Q?zbOBeJM4OtzmrQ2h5fe4R1fiF87LyGZ1xeoQsmT7+xWpBZGnn7o3Dmn4qxsh?=
 =?us-ascii?Q?CV6YzIRqxiKJUmDEf4wfm2qSRqShLuTTS2iE05F1oL2pS6Io4kZL/a/0enWc?=
 =?us-ascii?Q?vI2JyUPRedNXFLwDPQDCxERD2WzdXEPUuQLY5fFhqWZ/ZI3jjTWZ01S6ri/+?=
 =?us-ascii?Q?mvBZp4KwhpM0GTwrwn9lgAYgC6zTDGU+YPVd6YJIpOG8BHSbwszEi1bTGQ8/?=
 =?us-ascii?Q?+/JjMdqzYhG8IqWsRi8pu+sucHyKLySQZml7lsn7YWhQqvXhe71pvWm3U3TC?=
 =?us-ascii?Q?7UmJCQ6FSr7VLhorjrYGGC0maedBa46Cy3kY+Fwig+roaCnvVdxC0jyTcbGn?=
 =?us-ascii?Q?0H0ugQ4aw7jYyfdHDX01plWVa6yrTcE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZYg0hFal19EHkNw8yX5t204hESyu8h6SwCiAU0vVoz2ULPlSzQFsDJBBo13zki7Z6ou2LaKcjJShFLN41pwmFEF99mXviMbUQXB5AwdXQKhWZlPNgQs896Fn2Z9jYcMpbyibi6dZsF+U71p+tQjqcehahR1jN1h1XgY3ZfeK8qY71wYwLz9gflz2kedH7khrJCgy414XInomy8mPXHc/bxAK4wLXlUkwyT45QseeTE0J6hosfnJ72tQWOCFM596fEwvzhH0NNIVZJ3KLEYf0xo/DBBH7xjR5gKynMaGV2Du5781dWbla5Ge6zD3vqe/q+hQ3qp4OMqxAo+5De8B7AT3ok69H2nMxlw6ITublTNqybrA7Lsd/SJF7bQSKHm5FEpHXGTLoNxAvggqlQroRn3L7p9eabDTTg/edlCWhOOQHTFdlKPNzaO82xQ5j9Fcw9Nt44KvZRkq6UeuebQ55vo+BIY2HERGS8mZHAQ5L/yL43oXvGtl4gtZYZfBGFeNcn8QDWZXKABhKSbd4/pVM1dakqFXBTar79zIAujB8b9eTt3/WlhpnZGtJnY3m2tafvHStu0d6go2XhM3Rkg/3Z/4KaOs2DGVl8ADWwFVyL7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e2e358-da73-4626-cb9a-08de5cf82f2c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:30:15.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJBptBeiHJlrd4gpOLmJdGr4hgB01nxQEk2Nt0uLOX0Eyex395R53g9DgSN1fpE6pcV0xTFqhZBsebBpvG882NRDtV6G5y+jkCyDhLtFoSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE0MCBTYWx0ZWRfX8CS5ZdReA+nb
 V/aIAbBqz50UftxJgfQItZfqVR4C2rQ1+y762fHwDb/aPSek9C4C3is7TBbQwadwg+0D/hbwYUb
 e6OFiQY5H8r54natNpfvkpo41dlGE6Tv7yIvpN6WR4PfRGZG9M2KrZ0yart0eDUTDoYiYUAsPtE
 PWotoOhDWQjHquePj4rXgV6EY+/CCU/tIGJTMdCWhCZ7wJ2oPhOEiz8JAcCgdpN1U4zwXPphmga
 Pl2Fww6mXd8iCA1/11cLgi9fplOEIl+MzwmqIdy8xI1DXSti+u80uJmW/vUgo3BzqASDMC0yQC7
 grTNR3vb4nzHfPst8Ii4XX5eqtC8rWps/Fp4Pd3yZG6oVBMulu0xuje7pP7eYTc+wXEnlHjWrwO
 JDtiDWerCZ0L/1m3i/9pBXxeIMjzCIIUSdN4acPIpqJOljjsPqUMqusWElzPNv2f1mN7UZlAxEm
 idVN3YHgH5sGs+uKK/g==
X-Proofpoint-GUID: lOwezBFLs71L-VWL4eg1uedzBXtn5_AG
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=697796a0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=D9eh0rtjn0JhTP9QflQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: lOwezBFLs71L-VWL4eg1uedzBXtn5_AG

Hi Andrew,

Could you apply the attached fix-patch to address Vlasta's nits? Thanks! :)

Cheers, Lorenzo

----8<----
From d6f05f5f0c2ada298e90deaaf3eefdcabc4d344a Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 26 Jan 2026 16:23:16 +0000
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mmap_lock.h | 9 +++------
 mm/mmap_lock.c            | 6 +++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 23bde4bd5a85..1746a172a81c 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -272,8 +272,6 @@ static inline unsigned int __vma_raw_mm_seqnum(struct vm_area_struct *vma)
  * write lock is held.
  *
  * Returns true if write-locked, otherwise false.
- *
- * Note that mm_lock_seq is updated only if the VMA is NOT write-locked.
  */
 static inline bool __is_vma_write_locked(struct vm_area_struct *vma)
 {
@@ -284,8 +282,7 @@ static inline bool __is_vma_write_locked(struct vm_area_struct *vma)
 	return vma->vm_lock_seq == __vma_raw_mm_seqnum(vma);
 }

-int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
-		int state);
+int __vma_start_write(struct vm_area_struct *vma, int state);

 /*
  * Begin writing to a VMA.
@@ -297,7 +294,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	if (__is_vma_write_locked(vma))
 		return;

-	__vma_start_write(vma, __vma_raw_mm_seqnum(vma), TASK_UNINTERRUPTIBLE);
+	__vma_start_write(vma, TASK_UNINTERRUPTIBLE);
 }

 /**
@@ -319,7 +316,7 @@ int vma_start_write_killable(struct vm_area_struct *vma)
 	if (__is_vma_write_locked(vma))
 		return 0;

-	return __vma_start_write(vma, __vma_raw_mm_seqnum(vma), TASK_KILLABLE);
+	return __vma_start_write(vma, TASK_KILLABLE);
 }

 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index b523a3fe110c..a9ad6a573270 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -136,14 +136,14 @@ static int __vma_start_exclude_readers(struct vma_exclude_readers_state *ves)
 	return 0;
 }

-int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
-		int state)
+int __vma_start_write(struct vm_area_struct *vma, int state)
 {
-	int err;
+	const unsigned int mm_lock_seq = __vma_raw_mm_seqnum(vma);
 	struct vma_exclude_readers_state ves = {
 		.vma = vma,
 		.state = state,
 	};
+	int err;

 	err = __vma_start_exclude_readers(&ves);
 	if (err) {
--
2.52.0
