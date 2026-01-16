Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C0238D52
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570695; cv=fail; b=dsyEZ3rBYAxcahHsk9BTiwQ5nCxFCOWXGSYzKPuFJXMjD/VF2jwCR6g80YyJ3dKn03hB4YaLgn41OBEsYXRwA7seC9+jGMbjS1qzpJhzGdXS2d6MeIq166qQ94mFeoVHmo9ifgV0rn4hYJ2wYOM2J1BwinaAXJ4eZo51MuiyCxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570695; c=relaxed/simple;
	bh=qE8t7q3sXDumVGueaDF1jkRCHZLxRt1mTaAqEMXVoTw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P0A8akvPjekWCvtPNaJDTqb+RCW+4oZABIm/S7PClFQ5vVZxGHfdyTzjXC7FFE+HSB3AdHhtwSiVnYjShW50ZEhpZF0ypuYO2p1/GwiEsBIPtBoWreisCylEd2Ezh5beqGX4gv8F4oOJHFpAVXSVxGD3YQ2+OkFm76W7AiWJRrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r2hBpJ33; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OQuIyNCZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r2hBpJ33";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OQuIyNCZ"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GCoEsk1909898;
	Fri, 16 Jan 2026 13:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=MOTcX00IrivK1iGT
	QkKIM0pj9ueXfocPrNw0hIuwGKU=; b=r2hBpJ33StgtxGN1TUIdlukSRdbQk3lh
	HDIBMX2+kHAcFugNwpOBbohkpTkO8bbsvVYw7rR0R+w4kslJ513DL2o9CzAUsqMd
	AeJi606XrxpQ+/UPgmhkg8gdkG7kMwE1YOg2gGqrS3XlY2uNhxLiTynG2MRaDwTD
	eAnQptPeb+jgzCykm8jD72uENJNULu66DmkDWpRO1JqLY4C9s1+QkYWuCZcTozbk
	wb3MYrWNOeNvZRFHMciT0WBo/91zzEST2R5I2jQsEuXcox2Y8kohoTNL6rOwYEUi
	CTQnk6yKFRe0OYWHL3FlU8lgkG4TrrKGnX5SK5DkSa0H3Vy+j8C9NA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkh7nt2k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 13:36:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GDL0Su029434;
	Fri, 16 Jan 2026 13:36:54 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7ppbag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 13:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xX1z6xaYMM3kXXAyD+jLA5r/+3p4cSYI8Lx/IW6hiuGJsMDmqiJQnVlt0i5EBRXolglu8gG+PnO0h+CbiwHgh5paGfnQQL/WV4f2DPuY5ogkUKtXVXlXKKHDU2aC9cZgbaZFUxfrKp2BfCLoN6l+nCzIryYabN5ZQ/GX06c80bsP1OU1HuxcCf7inwSg4B7CIKlk8NruNkL4vmJ1hueVHDkan3/YGX9uKtxKloABVr2QtGGC9Zrzxy7tobgo1ckvA9kBVxBVC5g91bcGKwgTpuuBHP06gixO+qWof/vAQWnIGbIx2VjfgueMYMpc2v/dtjg24MxWf89gpSieCkissQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOTcX00IrivK1iGTQkKIM0pj9ueXfocPrNw0hIuwGKU=;
 b=kYrMzj/VJyEUYGxSkGZSfH+SGpEnJBy8BiFkEdYW+ssaNP4DDXyvEi4Kmt2WadSpqgGQgqJkjQ1ERu/34wzCwGbfM5tqctTHlKOy+3BH6dN6c3G0DE0zJtGE6PYPFPcL6lflKH0F1O2o/L1pB7XwSPakHylZR51nA2X5LM6s8QnBVIUsD4N0HplAb/J/oBNkx7VirTDRy8UCQGkaCZi7uETkdsNODqIU25Y8qjoHVopzpiRTJg5Dg8j6GD1XL5NgQ7/kxT7bGUW9b61CxIBbolLtn+LHSSwcZwdqjkj/SVjkGxODXGgR1T5z+2gw2/BT3d8DlCPorooQTJqApKcA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOTcX00IrivK1iGTQkKIM0pj9ueXfocPrNw0hIuwGKU=;
 b=OQuIyNCZrmmIm+FMUse2FgHQAeUdshwX4twyCnGRIhDMatpur2Othb3wve6ZThlAeQ1i5cADwMRmEDdnWaZaUu5K8JlyUibTP5/q3aiJtcSrt0Oi69Hts3zTzVjeU2yoA/SfNy7KV/IxYDdX5+1s3gqoWa2a/y6OrD6N+3XcfDE=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH0PR10MB5659.namprd10.prod.outlook.com (2603:10b6:510:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 13:36:50 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 13:36:49 +0000
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
Subject: [PATCH RESEND 0/3] add and use vma_assert_stabilised() helper
Date: Fri, 16 Jan 2026 13:36:44 +0000
Message-ID: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0282.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::17) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH0PR10MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd7673c-6846-4d9d-1181-08de55044cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bIfI56tYa0OY9jrfgXsWmMphACmyHq5HnSVk+VdvAm5ZNdPwxGQHVBirBz7y?=
 =?us-ascii?Q?a3IXZwxwkiI9pUaiwWBiHdahvPHlP86HKY//qhW5YVnPGgFx+opQEcsyrLZB?=
 =?us-ascii?Q?jiOL69bSPVtloktDkj5Rc+/47oxRwVUVo+2TOD7otcGoRx9WnCppKsEfT9Fj?=
 =?us-ascii?Q?jV8WnRNfFPBCi6S1jq7KQ7gMUMRloyGuM6DBecGGCojU0tryZl9Ku9Q6glMs?=
 =?us-ascii?Q?inGaqyvoBMZhzRdL8MPUBIFfFAp68V2XpM8jckrL35qTvE7vR10gCPyLTjX4?=
 =?us-ascii?Q?ZmbkDx+RzgXFUXp3q+nX90RvQO1hw+IFuG4RDcQS5nWkU1Y1XFmHoOYSlCDJ?=
 =?us-ascii?Q?O2i5vMekjnZS+3MH3pMaG6ckCzF4FFLwUmTGc52mXiKlLURVSd75Md9Xj9Ao?=
 =?us-ascii?Q?MdqpWg5QWSKx5/IgIrYyZ5W+35EHPH7MB442/0CwMzYIUk8P9BB+K9Ac4Vue?=
 =?us-ascii?Q?uResM3MoUFXc81Kq20epMF4CIeWdDKV3MOB7bPHej5PNtArcB2+/qJqJJ1Eu?=
 =?us-ascii?Q?rmg7qCS376Au6WvljlvlMBHKNrJUoIkf/v7wwwNZZ0OwwD5Rcbe8ML1FUVOm?=
 =?us-ascii?Q?0gx1bM17po9NONJvqwjGH7ONi6Sp1zXKTq3hJzPRGHrmdEcgrQ/mia8pieit?=
 =?us-ascii?Q?61v4za7gPv5nqGMAhGaSeop7yq7JMF9sDbLPk3L0hNW7yw+LXgtzqfr/9YwX?=
 =?us-ascii?Q?EdpC0b1dmhgc/KCYOfuKuRrpLelO6btt1QCYSrzcsK7h4bYIvNZXsJeeGHRH?=
 =?us-ascii?Q?Cfeus/IXwUZVUXCSbj/WWgtYvCdLFl/9RwVciZ6OSmKa8ZJNctdzIa3ARsnY?=
 =?us-ascii?Q?L9AzksfMlbPdkm1aEvDsRDtpgejdI/K339GJaIoAhr+n6CRuIyOgwxzi0MO3?=
 =?us-ascii?Q?eLoW4QHpT+ReqIlvVOr3KMLMDXss3uHsNDobyBxzd2J4cRJFhesYiLy7ePD0?=
 =?us-ascii?Q?IHyTyV8MzAf+pfDoePi2qdnS97cA9g0YHP4+uYm9sTbGWmik6+eiaygaK9Fd?=
 =?us-ascii?Q?c0fT52KJe+wEsYQZYUM3KaQV9abA7ngSSzTXRQIYwYLjAfrDcAPr2WzqDydz?=
 =?us-ascii?Q?qUMeyDmy/lv0f4bb3T2Xfb6tqctDtlsgvzHIyD1cNQYERg63FtMScKLJBzKU?=
 =?us-ascii?Q?YZECeGn8pvIdOhOmA7SyVUXPcOFpERg5c0fEtbeNpmfBHTdh5uTMi1Yo9ac+?=
 =?us-ascii?Q?AIY71U7KJ63ExTlohpa7tNJSVbV4IKKcZIe3ibW93/UrTVbhE2Qa9QgMgnPM?=
 =?us-ascii?Q?kSOd6re9MSMnKfdLizdNR80mb1Frq4KHN0BjBYrkyMHV9g8HkPbXuV5sqHKz?=
 =?us-ascii?Q?xxGL0gkxt2qT0Qe0MfLzsD4yTqvVgerLa71urTcCRC0k+XqBr2Kxlcn7nalc?=
 =?us-ascii?Q?bzdIQZXcNvEJm/imPe5V2b6V5y/c0AMSiwLcjn3qFSPxZ8uI1SFmF+FEfGic?=
 =?us-ascii?Q?fFMtolayakdo3AeJvBmrxQllFRYkevErUYQlZCA5KE6U7WoRYAncPioxUsRo?=
 =?us-ascii?Q?4LuWiILzTdnppF0OIVOsDNGBD6LE5KvcKSFp8Kiod4vcpjhGPq3dPhvlHE3H?=
 =?us-ascii?Q?xoIQ/owJDQ4ivEp11Fk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oVwGRAEqamlbqlHhh9FhkQXbISfV+6JBJkQAN7qipPwPctwfUub7MdeTx9mi?=
 =?us-ascii?Q?ffhvFdG0VEip4Ri83LbzGG+gTbt+sY050NHV7bQT33+aLTDK+ufCTmozR96s?=
 =?us-ascii?Q?MWALfQUjMad/6jIaVZH+VjwfJ5yvhg86dPOjVBEKxL9vz+R58K/Cw/YK0jtd?=
 =?us-ascii?Q?hOMXoZ/DzmrqPiI/3NB34BbCcQdYRN6V0TPkQuPhVQcdtNhTQ9/ePfPp/JxF?=
 =?us-ascii?Q?nTRYSo12MMdwvGtkB0b7zsSzy/fcD7YW3Ck0Sb7OqLHfHqsD7u9wvF1IbIDP?=
 =?us-ascii?Q?cRuGlyL0I0sb+OnFisigwW9PAZfTQCDAaOtj7sBsMj60XdnJWN+erjeUfHAl?=
 =?us-ascii?Q?iI30JUjximwrED6bhMuqmF2aH9c8y+EZ4JkopkRb/vKwMZyypz89roW3KDqj?=
 =?us-ascii?Q?JxEVd3mc8CbsKFTpN84AnON1l4VEmiY1pGB94+l+9IM/bw+zwefhgnsRTDXE?=
 =?us-ascii?Q?e5JF47M9gphZ5P/upBxsw7BN+9CQ1e/hPr79iIK4uqaitXKGIscWS5nHSK51?=
 =?us-ascii?Q?ub1ssU/ODCJv+vLosm6Si5tZKs584oKLrqW3UZyitgpAy6Knt0ckvwEzhbYj?=
 =?us-ascii?Q?+zF2qnKgwrUGnMuSTyy8fnIF/uL763kx33T6NjJvoCn2JAUxobOmwAg2lpmf?=
 =?us-ascii?Q?heOXulCeffP2OPCiPX2V6C32oCT/wnQIV0bsmntvrf3ad+tNMjD9/fgyHaJ4?=
 =?us-ascii?Q?MAA2/9me+8/o+kjEuBrOpb1xAS/uC7CRiLpw1Zs8Aj9byCFtgR3tDjQmfKC5?=
 =?us-ascii?Q?ASU4cjBap/Ossix+LJQVEDUYHHZ8Q8Y6ViyNeY2ahfq1G0iT3xPpTqgke9pE?=
 =?us-ascii?Q?sAwm5C3TnmFMhwHzVQIgauG+Q1+BKbksDjN8OrxtYsmZWV94t/DEsyWJDptx?=
 =?us-ascii?Q?IBTuQc6UHv3kLJCymfD/5MUtWwtDEkD3H/2GuzZnNis4/J+fPtUuW4wCIqeM?=
 =?us-ascii?Q?1RBc5hUu4PCY4h/+MoEz3gelR4HKYWKsDTrIDqT2afWb5obTWFnH/STOJR+U?=
 =?us-ascii?Q?HOc3hWggXO1lWrwYgQ0r9AECVrRJv8aRLQSW7CtZSO/Z5W/ldwQoPOlluSRe?=
 =?us-ascii?Q?szFKsU76YVigGteEGIUYbL8jcLZFpm8hIQqrC253XlsCiWqGVexTgslbVO2Q?=
 =?us-ascii?Q?C8+6oUVfUCbFAyV12hc76sRcsmVVjIh3zNCd1oWnmJXJ0hB1jGXoYHMzH++3?=
 =?us-ascii?Q?l7/VYVjWQekY9jcAleb7lBTLlvmEG/MsIXQzP0uM0hmKvxmNCtixLb2NsBhl?=
 =?us-ascii?Q?foOOQFWj0Evf5BcL5bfexg9uLqJLWAasLzS1K7E2FfVbpmpGsqqt64Wn6XRh?=
 =?us-ascii?Q?SwnRZokJ1uaA/XKVblrZIJpQ/6o/k8SqXlqMYfLNeMULZ1VplGUo68nqTSCx?=
 =?us-ascii?Q?NTafG9TPZybuNsmTSBMjElLvlMhxCiqtu4sI0SBuYsgsXsWwd/x76/Qrvqr6?=
 =?us-ascii?Q?T3EJWWvHCxq5GIsUmaVEmwrOmkVVcN9pgENKmYce5W1frvUAZKqpzEAIu9Jq?=
 =?us-ascii?Q?2i3ihrtLG4RAj82QxOwqc/kPoaDBU0hW9FsT7LIGu3mYYJgSrGPf64tj9ARU?=
 =?us-ascii?Q?NHYI+AQm6XpwCYe5UJuPKKdoDO8nLdGN7XOhUXT2TQboZt4QyAWXfC8GttMV?=
 =?us-ascii?Q?mlOmWp4AfJ47AkCycWFT1I2TnHXRQmusgmvvOmsnlsulp/7B36BEnNDpXLIx?=
 =?us-ascii?Q?nYdMK24jy9SEcxZu5609x8ooMzKmIBBBkdwRNDXENmFUls2b/EbaL0XPmtK9?=
 =?us-ascii?Q?aLXXv3CGd1EwZPtlLNblxaCexheCluc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HAXQL0fTQUHpxnxEeUDx0A7RwgWmyGyT1Hv5yE1GpPrvWAcZ4et8vJTGnw8vC4Oen2IPuwftwv7fTwmLyKtk3VRH0swq9OIx88O/LQrNwkwwcttk6wdllssmPzslRkeqhdpXotxIDLjZQ62mWndVEO3Krn7jFS97lr94JTHV+2JbVqfuvNsC3JwBz3l2yqWe/NGK+YRZgjOdt2FR5DBg9NZvioJRtAl1cAulaT08okp/xRew83wNI28XVlF2R1CxteCQKHZG/gRT6ooCKzqTAzS8IUIE3SggmdszSDv80O8wBZ6Y3YzVGVAvcaoabPaMuQmlV6QnygbUIRkykxIXJT65iYpTxkHAt6HBW8RdLyDD09j6lskFvAsuy5TwgKgEj9wai60G3Wg+zfMJ6ySlULvAr5AWG/Wj1K3jcvwmds5wE/rTgr9R/LRnRrDatL7jZwbsaAL/6NO7WBHEvUaY2XdyQsKnjlrWRkAxHcEWQjvXzmyT0WBurD14sUp2+5EulyHh17HxrayfAtYLpnCtadJBw9yHks1rL85m8yDBn9CJPWlAlbJDcMY/gcnKa9zYec08XSZBXvGqAtCgjI7ejGts3Q5j9yOHn+jUN0k5Ci4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd7673c-6846-4d9d-1181-08de55044cbc
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 13:36:48.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+EndH7BaKadm7vmHh7k06L2zwK+M1MpVp/U0zlsfokRbS4LbJwrMvamzoD+F6D9dxZSkHDeGpMP4I4ZHm10/pEMSU2CsbxzgBlOPbowZeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=726 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160095
X-Proofpoint-GUID: W20kZZsHlzYbA-EpsPfvTGyJTUNdqfuU
X-Authority-Analysis: v=2.4 cv=X7Bf6WTe c=1 sm=1 tr=0 ts=696a3ef7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=3hpcEApNCGNIUVcqPkQA:9 cc=ntf
 awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NiBTYWx0ZWRfXwGIChaWSoSKb
 //LVLBbMD+zLfNEVy60i4Kfj6Z0HU/J99dE4fzR9kx4h4R0WvlIqOEOZYcadZzWJHoMrQTwqy6h
 igxN/B+fxLNW4at4qwukuqYmiUbsSibefFV/G+8VoYLIJZdSd6OOWuabELF7BddcwrUAH/ArqCz
 kJRuOBNmq8NsrShBNg1NqlO5vdVfEd4xyq3wf5kVYjVrieUoKCOpiDHpG5IRefsJNBTALOzsJ2U
 HiRCiCFLm2lHIHKHBCLj7GczX5W2LnIfvmlolXNHxmBvUo2pj3dKM+uJ2VLIiFjD87xvy85+oos
 kdZ3fxe3T7zvc2gBapJFv7qRnqg7UrqzE5UW9EMgSVroHCvEbYzRiNeblId0P9UaAqJVNfpQLMK
 CIKBXPr36VIoESdGi/HnLl5zQNY6tT0bi4ZzXq9Mqu3im8bRnLAwHh8ycAKYCcPaPZciqjrlWQ6
 Gy0kWBxkWjwz+RgakzgZSZTIMg7JJNupshYn1RyU=
X-Proofpoint-ORIG-GUID: W20kZZsHlzYbA-EpsPfvTGyJTUNdqfuU

Sometimes we wish to assert that a VMA is stable, that is - the VMA cannot
be changed underneath us. This will be the case if EITHER the VMA lock or
the mmap lock is held.

We already open-code this in two places - anon_vma_name() in mm/madvise.c
and vma_flag_set_atomic() in include/linux/mm.h.

This series adds a number of pre-requisite predicates and adds
vma_assert_stablisied() which can be used in these callsites instead.

However the asserts implemented there subtly wrong - if CONFIG_PER_VMA_LOCK
is not implemented and the mmap lock is not held, then we don't actually
assert anything.

Since this is an assert that only fires when CONFIG_DEBUG_VM is set and the
test bots will largely be running with CONFIG_PER_VMA_LOCK set, this is
likely in practice not a real-world issue.

In any case, this series additionally fixes this issue.

As part of this change we also reduce duplication of code in VMA lock
asserts.

This change also lays the foundation for future series to add this assert
in further appropriate places to account for us now living in a world where
a VMA may be stablised by either lock.


REVIEWER NOTE: The prior-to-resend version of the series was sent with
insufficient caffeination + my having inevitably got seasonally unwell so
isn't worth looking at :) Treat this one as the only version of the series!

Lorenzo Stoakes (3):
  locking: add rwsem_is_write_locked(), update non-lockdep asserts
  mm/vma: add vma_is_*_locked() helpers
  mm: add + use vma_is_stabilised(), vma_assert_stabilised() helpers

 include/linux/mm.h        |  4 +--
 include/linux/mmap_lock.h | 65 +++++++++++++++++++++++++++++++++------
 include/linux/rwsem.h     | 20 +++++++++---
 mm/madvise.c              |  4 +--
 4 files changed, 73 insertions(+), 20 deletions(-)

--
2.52.0
