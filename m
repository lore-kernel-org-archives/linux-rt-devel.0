Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728B2110E
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199168; cv=fail; b=s0Aw6VE/8iJOWzXViCT+EIuq9a5bReCHXYowcWlwITPR79YlScJOz5DvkfAEQ/+3EzIq4wpHWoncf3dbF+zdLoDSCFPpqRyTsDGlvKjOJZ4bzITfUWpx2IcUL9wSzYNi/iIscLB7ysmRlmvjHwVT0jH3NrUHc0Uf5hT4mwQoJhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199168; c=relaxed/simple;
	bh=JXjXFai20sajtcLJZvvK63oayM0Vu9OmXMtWOAmDF7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=skYOFUSmIrQSnoOt9K3bGAeiX6skazvA/VgpJb7JnMf/coKm31ZInUPmoIgFuHeqeq9q2lz5M/kbfltveNVxZVjdCoRFXIxbgd0nFU07+VORtxZtPwjN2fFpDRfPQkPq4/K4mK4s/pMs8KwyCw5ibqUrE6BizO4shKAeHvo0jqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KxDmHMcC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZFnwkU+4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KxDmHMcC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZFnwkU+4"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NBjs1o1674936;
	Fri, 23 Jan 2026 20:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TZugk4ONtwUmHILNMZMJnCWibT8Rl7AgMlcKeFVzyng=; b=
	KxDmHMcC2MyX2ZCfLbHjI2WXucVe0MXKCz5ERRWAt2LxAb+HXse3JWteknIgzF9w
	HvtCxK0ig5oxxqnfy/2QJqbWAUWtA5yL46h6fCuUdGnZsyNRi72DBZBuK3zcHORA
	T0ZNMGma2HMyJ7n4DhQ/pUeAsriWFGOyxtlHzKB3c6Ui10KIfnxFnVxXirsiNuOO
	jt6GQDhXn/wXWFtQpshIXJihvRIwqv7wJrMGRMyNvLoUiIKmR61Tf8S4hBJa29Qt
	m+ZhS4ffm1xDVQ6u2Ym1JWoeHp8keCu9lcsmi4mHnjHgQ2+aroGfS/zF08aB75Xc
	v17cxrK9CZkVxiltT7TcLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10w32nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 20:12:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NK4eN1033115;
	Fri, 23 Jan 2026 20:12:25 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4buyvfba2c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 20:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt4zs3UyAVln6CnKXpZOyehKc2FycBK6xNYkNuprR6fdyzO9azCNoI77ScevzgFo6OMJAXreUoLW4cJ4aKphuslsAPMYzb+rVWasxMi913D5D5/4RTF52fFChtFgVFLA1YSEZlfpwswla3dGLgTozK9gUr+RkFKfXsRZ8xK24m769p4PK3ZGhYEs89iCURiezcIZYxiN9O+fNk8REovzTHmxjYFy8ZZOTewLhP7AXWNUUGNvPXnqsI0G5aJ8MqWJkKZdWnJWUm5CiakZPk0K6OYKCWmve2+pedVJ0vSnO6IFY3OyqsVFcwzKZjXwkEyVwU+t49/YRAjp7wfkxpx9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZugk4ONtwUmHILNMZMJnCWibT8Rl7AgMlcKeFVzyng=;
 b=LzJBz+5muZiYrn7T4AcpCtK8tpkGKAQfOHE/NjD2Caqajud5V2gaG96qJD7V8U/RVvZJZSBhrt3JWStjNE9BrcgfjqI4PbwRKZenPQ+m3dlqAcPpkAt7XGvTcWaNftl32x/iF9w/AcMnRgV2hPb7tGJya3OW/wSzx8JvxWwNbQTiKbKd61/KeR7br3207u9N+LJevYYmRHirY6g6ozAimkTEXotoW4v4dWK0M0c4jjj4SWxnISgHr9FYcJY6ipDvJ8Ru7CB1nbIVpvdfT+WcK4UjC8l3rrdw08TaFgxxq1CV1aiGZuichWiNs8rqe4LwBYpYt2tHjWxvJn+gypTGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZugk4ONtwUmHILNMZMJnCWibT8Rl7AgMlcKeFVzyng=;
 b=ZFnwkU+4PXaNcwyrR735LE6RuTO4y2bhdTImSExYEURkxBf03qPe/ng0zpQnhwQpFPnHS+hQ4PtzsTZqyg76p9JvF3SuAzuxufACkPZ8qKp0NlcT9NARy/lKtuh6+zy+WY6Is8KGHNOCcIIuKJq+0T22mIbBjVTRnWOKBPrv8v0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH0PR10MB4536.namprd10.prod.outlook.com (2603:10b6:510:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 20:12:23 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 20:12:23 +0000
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
Subject: [PATCH v4 01/10] mm/vma: rename VMA_LOCK_OFFSET to VM_REFCNT_EXCLUDE_READERS_FLAG
Date: Fri, 23 Jan 2026 20:12:11 +0000
Message-ID: <817bd763e5fe35f23e01347996f9007e6eb88460.1769198904.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH0PR10MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: a608e0f5-4135-4f8d-aa21-08de5abbb833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dm103wiYmWSuxrIUEB8pPGKAnQKzhLn/Z0dm8j+yxqwcxdw+qGhwlzf/l3Wd?=
 =?us-ascii?Q?fzf3HR42lsb8ChMV9wm9Q6A0bI55SlDdiu6P/s8HAgOOUFWmuiwCn5oZwCTo?=
 =?us-ascii?Q?WncSlVp+euJEYfjOaySMfbcHn0Kafm++KMUWPg+nA6PbwBgY1djCffeyZhc1?=
 =?us-ascii?Q?jWvoK7FQtKtfo8U9gXRvAwFwS2o2+I1/iS1h3CEoAQyvS2YnZTWL9dc24b20?=
 =?us-ascii?Q?yMj+6BKj7ooEEYMO6CX6wVwL19ELKUS5KQ6ukR8vf1vvF7m9pog8XeLuxKaQ?=
 =?us-ascii?Q?+ZU+Cn43ZPhi6YQbHgN8RQrikl1i0n3HS092y35+CuFYbya5LKM/45smY7Z1?=
 =?us-ascii?Q?WBomPdj3YZ751EolnoVK2q+PqkkReDOhjyPPsZI5/dA82wf1wEvbQDTeUeA1?=
 =?us-ascii?Q?7CJ0f1M599CJ4p+aG9uQ9RjrSlBNnu1fQaFKg4FzKqtaiaRowF16zUrmGxYg?=
 =?us-ascii?Q?OSLfI3Zbro5e/LdJTPKg4fAuu9Kkh5Q9WlbCaplkF3NMXlCBvHJBPX6xjWOa?=
 =?us-ascii?Q?s4NONjMu49aQ7viwkCGA6nKPvfKdO9ItHnMMq7C/akehxbVJCbYNFDMRTlMu?=
 =?us-ascii?Q?nSTHZKPz9JchiM1lYytdxzUGbMgejbjHJN6/qCVUsDkAeTmB2AIfgLPv6euw?=
 =?us-ascii?Q?oIcmAvgiP2YAeVe4ZaNvXAB0oYmzcohgcExT60MINuxO+3rm8vy94XV5U5/O?=
 =?us-ascii?Q?dsf9mfjGyGqc/BbmEAZ9uWj4sBvyFVwVYfnrQd5R0qOEc/MMByFtt+2A/pyU?=
 =?us-ascii?Q?lgkzvmCGxo9HhG7ylt1+X4Qs+HZIE+p2npSX5qjFvr34pyko6U6Pd20p2Tih?=
 =?us-ascii?Q?LhaTnHLAfbqxeS9k3rOaf6k3R7ZnJwDwGEwPMMqFbTElMmi99kHDFP3mo42R?=
 =?us-ascii?Q?A0X9uRn2mYTDZ+Lu66GU67QowNhpNRfpTpGyYckPlsd9a6w++HPqHV63hfe3?=
 =?us-ascii?Q?ojHzrHoGwFxAmbBSXctQcyqMJuWXmqio29smPtqdIBJJtDd22c3wO+5jOhq1?=
 =?us-ascii?Q?F2DJXwoqYgfUwJidyB+IzPxzMAhTiGUpJ3h9ughgmxmOQKJLHP+Bcut8sChe?=
 =?us-ascii?Q?EQgFo43adYaywhTDcpI+M4H3NWbI24yLOzYlya1hqzTbDN2ZRACNRE1wCuAZ?=
 =?us-ascii?Q?6u8w3n0mxobiD+3qwzpalf9kfC4vH5Y3lF/1RsBoe9vt6TFEsCnR//D3Qe0j?=
 =?us-ascii?Q?ij+Y6MObaQdKBh8gtUUnBE9EALDjwrxP4c0i0K6EBB4XhVqZHNK5gtk1Uygn?=
 =?us-ascii?Q?wAgAXqGEXirSjWogQmOAccpMom8j0W+qkEFq1HwPPnIJLz+lJnYfyJQMAk8/?=
 =?us-ascii?Q?ot/mgPndjoMCgb9XZ8ziEKfrtejG7uOp+KwZeVclB07gEtyIuuqFWDmTHCFs?=
 =?us-ascii?Q?BCIaGukR+N38+vwyLDtxnhJmtIXlHzcmyCsibEnr/aqYR3iI780/nnILICYY?=
 =?us-ascii?Q?oyWOhKQ8y0GIC02kMcrAdEiniRLLJnZlxO5YdH3NYhCOggLBCDmkwiIrbglv?=
 =?us-ascii?Q?D22JZ+wTEjJMAMaUI9y4+7Jvg8P2hSELHMhrz3YtDXRsycRASGmUWXFbXwod?=
 =?us-ascii?Q?JCigsS6bdyXuAlsgfW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y5fIvNFnpYja74YAZWhCu5UVo5+UfL7bL9VvMYZG/VRUqLfl16qqdiJ6yA6u?=
 =?us-ascii?Q?KjMnE+8FrSD6A0/Ln0L2GaBx0VxCS+W+nzXlG5h95bQ8aOYzluXwyysjxUGq?=
 =?us-ascii?Q?HdHeWBte52WrZS75OfqpmLjcWSdU4oXc2g9UQvAE/3kHxcerYT61o9K/iOht?=
 =?us-ascii?Q?On3zJCYX6s++A8j5vTVbKcCMlZvfTQadK+90PsQicax7hd8v07u7DGHioNbX?=
 =?us-ascii?Q?wPOIm4xp4VF33DL4rJKLZkeXrk4W5SztB0DgxK3/+J/eOMXwmfUrkRV+BhxG?=
 =?us-ascii?Q?WbyBC7F7Q9n5YlLuikSEfyBUoTJUBFLDWzRFza0Kc7GYWdL5A//7YPkRGSOY?=
 =?us-ascii?Q?YhBRSkjKEoOodkZKNGT0wNXziKg6wmcmuCUY5FsVYI7zRl7FomY07rhMEuR3?=
 =?us-ascii?Q?ufnSCN5w5PFvTh7f1mGl2UaEiAS6ZdYcU0OQAUYX//p//gh0KoQ6V1t4Ia6O?=
 =?us-ascii?Q?QFH5p27lcfjAFqRNM5XAPkQ0UAJZs/zvD//PAc7r5GEN/SzFPlW1hg2OC7O3?=
 =?us-ascii?Q?TO9iA+QvTcuag0T7uhE8cqUBq7ypqmuTtiK+OoSYkMlQinyrzni7QVbkMpNY?=
 =?us-ascii?Q?Gbu5kKCANjD3kY4BbWNWxjw1ivW1mdkkXNOFN7lMB4mTp7NbQWgrJIghqbyu?=
 =?us-ascii?Q?DRt+UiZ3cPy3QPRF7I9OGOgqNmqMGwY7hxaVZO2O7wDkwbKkJIJKPhbBycOl?=
 =?us-ascii?Q?iNv4JWC7ZE9txTbPiNcVWgaPUBcXOnjAsrWn+jVkvqacVPap5nbbuEke6sXA?=
 =?us-ascii?Q?K+SXva065w+Xu8VCTae+9SHYDDX8rXUpkwudRn1IFZXOSDxZyEY3kXLibiHr?=
 =?us-ascii?Q?3UNa/Pg6mEWQHaZDbPwWqHMCrC/qKcup2YcbENNrfUMtVUtkSzaW90uRJBv5?=
 =?us-ascii?Q?6UhHj2Connxmm5Z/sJqQTbusGrIBhNc2zbjZsBt8M5uzr1aKzHB7bkNfA4W5?=
 =?us-ascii?Q?zkZbBeLd0ImuN+Yu/hYdfKJ4sMIW/2CNKNTUf9NURZ73vHgNYIWTs1FFOzzg?=
 =?us-ascii?Q?nUqHliieXRxnoBfH8nKzdelHj+Z187QsCAw+7o6jWaMCO0rYdpNNH37+YWR3?=
 =?us-ascii?Q?Y0YHLizGOl1MnYccbq/6iHdtIBRWzTvUgRy5ECX+wmorFxRnHevFZK4i/UMF?=
 =?us-ascii?Q?/tRij9JCtd5SchrvFky10geL6UVqiNiZIl23CCXsjhgtOXAYfKPLDr49XsZS?=
 =?us-ascii?Q?h09KZmoldhjiS7rMNRzvNsU/7AODHEZkBD4EscdJdNRDnWfKP3IxPQIXQO0g?=
 =?us-ascii?Q?P4HmF2C2LhhOfS2rKQGuzzQPO0/v5iYktIXhVCvSkJI2ljD5nCc1ndqlaNQu?=
 =?us-ascii?Q?+TVk+LMTm38y9E4R/BKzq/O8KoGTkS4YTL/+i81/mFNLmb5aCcY/VMguSuUL?=
 =?us-ascii?Q?wI7dsd5Hh4csNjWyY4QIcUbFfDRvF0lPO9xV/MT+czUPjges1QsKcrBwmsYv?=
 =?us-ascii?Q?lfZbvSqmc/Z87+XxIwdRPDvxd0D5vLM1B4KLIBTRoNQlHOTMTuhW8tcA/6PF?=
 =?us-ascii?Q?vpUy6GCd0loLRwKe/jth6qg56MnyN2nV6wwQdY4cBRSu5ZRFnQ6TZYGkYkRO?=
 =?us-ascii?Q?a3ndwOxF40Ly/3VnpQJ/LKqrftYRtdnTRnis5RAyo3jLrBJsMuK0hlaCaLm7?=
 =?us-ascii?Q?/lyUUCcxEy5NTXFAze7B54Pb/OON4NALNxeQpDuOd6mPjFWBNcqIETsxwNpn?=
 =?us-ascii?Q?/JGlp4rbDGcGZBk0T2x2NbMM4mYmat4amLetw/QpyDlvcwDndYgbYYBhLANV?=
 =?us-ascii?Q?RZB4vXA17baxrwaX+lDxWPY59h3N/1U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fFE14iPXitnZdtjB6le/IWHm8XF5wtfZPrK7HQoE5/HcBLTeyA/rgEbIqPdwrtyQ5orprmVyW9nb6ESox+HCfENu3AjmtAMX+ROpzMEjo4IqlmF4t44o6GGLY1MDI9aNbBzRVL0ufH8D72kNLkI2lUGake0SNCE/sKGV4ONCJDG1GtkXZRUV3TnUMPmB1iV57xD1oGZqM6T2Cma6YycURKVKN3KKN0Jmg4rBPuZ3uHBr5vxeBnQYnhIOc+n/bgOFALlQ9VvU4gA4KHclCro0aNJBSXUmnp50DNTEW/xoMq8Axp2XkqIK1/eVZKUEXMH0DdbYwaKoYpOi8vtUT2r5LkL3yvkveBwQFHYUQ/RgdKbcLoIm0DXSLgXvVElrT7+qGRW47Mss9kxABgbVPLieB2eOgh1tKYH+tFWmQ9xtCWd0+3lCjqhW6xrle7MzcJobPW6SojLvuCjb4eQzTomVod5mvKP0Y03pq3arP4zPpc9rJhAOAHOqT+9SOxi9uNVLo45CVwHGo0JEIumRyP3jDo5LaWMDw4ik4c7nf6cAsLh8kJUORiKsytuB7VHmYtjiWs+HQe1sXD1sbIKyNcEM5VHqW+H+c+xLvQVyz+twmak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a608e0f5-4135-4f8d-aa21-08de5abbb833
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 20:12:22.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bu1GOJl7FWWu/JOFXHcUJTVIg8+9dl3UH1HPzEib7jA3I6JTvLkgdvSzkdPMujA4YbCdTPyj8Z/R9b7ezupTXtwXIzXArxBZ4D/ZnPvkGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230154
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=6973d62a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=9TB_ZDaqR0cpHShmxdgA:9
X-Proofpoint-GUID: YVzsvvWc0tnUsIFEgdYl0X-_8xQWwxYt
X-Proofpoint-ORIG-GUID: YVzsvvWc0tnUsIFEgdYl0X-_8xQWwxYt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1NSBTYWx0ZWRfX6Uzl711B/pKQ
 jyzz7m2qLwXMYGIdr0sUBMHotNjTjzeHIBHgcFHf0t6eFTtISW7JbVm6hME22G/Z34Xk0OlwBnq
 eK+u7THQ13+SqwVz3VWVWewRDjiaEwG58sP9crjzQt+lZcBpslYqeYQtBi0a42KnvPUbZoNxQAY
 TRnY1XBaI4azikYx0OPCXMGwKuH2wQ3doYofp/MWkgS4V+SxqjHUA/AYJE6ikPSJVD/xJU7TWQz
 ewY8VdsTeueWeeudJ3BYtws4qtupNytxy610gcD9NY/BeZGlW/hL+QW97D8xBJ3O1Ekq5/YKJOO
 SwxuimiB3FStCjOkEEvm99M2KU17QluulPfoiq4ylNKoknSg+DKDb0eKbd+RoeCKhg2qwr6mukx
 xDM9Q2PmwDB04Hfb4NMGZRIYE3ummMYc+VACB5Sb0qfRsJTiC17uE2d81ChGZMKjr/ojFvUpGDe
 avmLGavusZ4buMKpZJA==

The VMA_LOCK_OFFSET value encodes a flag which vma->vm_refcnt is set to in
order to indicate that a VMA is in the process of having VMA read-locks
excluded in __vma_enter_locked() (that is, first checking if there are any
VMA read locks held, and if there are, waiting on them to be released).

This happens when a VMA write lock is being established, or a VMA is being
marked detached and discovers that the VMA reference count is elevated due
to read-locks temporarily elevating the reference count only to discover a
VMA write lock is in place.

The naming does not convey any of this, so rename VMA_LOCK_OFFSET to
VM_REFCNT_EXCLUDE_READERS_FLAG (with a sensible new prefix to differentiate
from the newly introduced VMA_*_BIT flags).

Also rename VMA_REF_LIMIT to VM_REFCNT_LIMIT to make this consistent also.

Update comments to reflect this.

No functional change intended.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_types.h  | 17 +++++++++++++----
 include/linux/mmap_lock.h | 14 ++++++++------
 mm/mmap_lock.c            | 17 ++++++++++-------
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 78950eb8926d..bdbf17c4f26b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -752,8 +752,17 @@ static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
 }
 #endif
 
-#define VMA_LOCK_OFFSET	0x40000000
-#define VMA_REF_LIMIT	(VMA_LOCK_OFFSET - 1)
+/*
+ * While __vma_enter_locked() is working to ensure are no read-locks held on a
+ * VMA (either while acquiring a VMA write lock or marking a VMA detached) we
+ * set the VM_REFCNT_EXCLUDE_READERS_FLAG in vma->vm_refcnt to indiciate to
+ * vma_start_read() that the reference count should be left alone.
+ *
+ * Once the operation is complete, this value is subtracted from vma->vm_refcnt.
+ */
+#define VM_REFCNT_EXCLUDE_READERS_BIT	(30)
+#define VM_REFCNT_EXCLUDE_READERS_FLAG	(1U << VM_REFCNT_EXCLUDE_READERS_BIT)
+#define VM_REFCNT_LIMIT			(VM_REFCNT_EXCLUDE_READERS_FLAG - 1)
 
 struct vma_numab_state {
 	/*
@@ -935,10 +944,10 @@ struct vm_area_struct {
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
-	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set
+	 *  - vm_refcnt bit at VM_REFCNT_EXCLUDE_READERS_FLAG is set
 	 * Can be read reliably while holding one of:
 	 *  - mmap_lock (in read or write mode)
-	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set or vm_refcnt > 1
+	 *  - vm_refcnt bit at VM_REFCNT_EXCLUDE_READERS_BIT is set or vm_refcnt > 1
 	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
 	 * while holding nothing (except RCU to keep the VMA struct allocated).
 	 *
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index b50416fbba20..5acbd4ba1b52 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -125,12 +125,14 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 static inline bool is_vma_writer_only(int refcnt)
 {
 	/*
-	 * With a writer and no readers, refcnt is VMA_LOCK_OFFSET if the vma
-	 * is detached and (VMA_LOCK_OFFSET + 1) if it is attached. Waiting on
-	 * a detached vma happens only in vma_mark_detached() and is a rare
-	 * case, therefore most of the time there will be no unnecessary wakeup.
+	 * With a writer and no readers, refcnt is VM_REFCNT_EXCLUDE_READERS_FLAG
+	 * if the vma is detached and (VM_REFCNT_EXCLUDE_READERS_FLAG + 1) if it is
+	 * attached. Waiting on a detached vma happens only in
+	 * vma_mark_detached() and is a rare case, therefore most of the time
+	 * there will be no unnecessary wakeup.
 	 */
-	return (refcnt & VMA_LOCK_OFFSET) && refcnt <= VMA_LOCK_OFFSET + 1;
+	return (refcnt & VM_REFCNT_EXCLUDE_READERS_FLAG) &&
+		refcnt <= VM_REFCNT_EXCLUDE_READERS_FLAG + 1;
 }
 
 static inline void vma_refcount_put(struct vm_area_struct *vma)
@@ -159,7 +161,7 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
 
 	mmap_assert_locked(vma->vm_mm);
 	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
-							      VMA_REF_LIMIT)))
+							      VM_REFCNT_LIMIT)))
 		return false;
 
 	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 7421b7ea8001..1d23b48552e9 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -54,7 +54,7 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
 		bool detaching, int state)
 {
 	int err;
-	unsigned int tgt_refcnt = VMA_LOCK_OFFSET;
+	unsigned int tgt_refcnt = VM_REFCNT_EXCLUDE_READERS_FLAG;
 
 	mmap_assert_write_locked(vma->vm_mm);
 
@@ -66,7 +66,7 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
 	 * If vma is detached then only vma_mark_attached() can raise the
 	 * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
 	 */
-	if (!refcount_add_not_zero(VMA_LOCK_OFFSET, &vma->vm_refcnt))
+	if (!refcount_add_not_zero(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->vm_refcnt))
 		return 0;
 
 	rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
@@ -74,7 +74,7 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
 		   refcount_read(&vma->vm_refcnt) == tgt_refcnt,
 		   state);
 	if (err) {
-		if (refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_refcnt)) {
+		if (refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG, &vma->vm_refcnt)) {
 			/*
 			 * The wait failed, but the last reader went away
 			 * as well.  Tell the caller the VMA is detached.
@@ -92,7 +92,8 @@ static inline int __vma_enter_locked(struct vm_area_struct *vma,
 
 static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
 {
-	*detached = refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_refcnt);
+	*detached = refcount_sub_and_test(VM_REFCNT_EXCLUDE_READERS_FLAG,
+					  &vma->vm_refcnt);
 	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
 }
 
@@ -180,13 +181,15 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	}
 
 	/*
-	 * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
-	 * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
+	 * If VM_REFCNT_EXCLUDE_READERS_FLAG is set,
+	 * __refcount_inc_not_zero_limited_acquire() will fail because
+	 * VM_REFCNT_LIMIT is less than VM_REFCNT_EXCLUDE_READERS_FLAG.
+	 *
 	 * Acquire fence is required here to avoid reordering against later
 	 * vm_lock_seq check and checks inside lock_vma_under_rcu().
 	 */
 	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
-							      VMA_REF_LIMIT))) {
+							      VM_REFCNT_LIMIT))) {
 		/* return EAGAIN if vma got detached from under us */
 		vma = oldcnt ? NULL : ERR_PTR(-EAGAIN);
 		goto err;
-- 
2.52.0

