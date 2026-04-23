Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D73603D9
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967265; cv=none; b=TSCUVUr4/6jqEtjae/Jv9HJWMHW7Nd1TvkXpfa8vR0/3G0b+QfkFMaI+J2B5I+Q5puoJ730MwYjMuRIMrRNRnUj/hxQyGuqrXJNTv3QmaGyDn9Zu523Ji1OIqUvTjjvXoKlQnrOW5hG0PeiOpaGBLzplt9k3hVfTr8AvHnjuI3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967265; c=relaxed/simple;
	bh=+JOes+x7cvfxfvpqnGSmuY6FZ+UQx4Y5GOdipyD8aWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dzMsiFjiLHenwUqjfDNOUVeJyBPA+DTj3s5oG1avxM1461qC+WgAmX+qfWaxrrBdlCri35q70rWYjxlCxZhMq2Cf/FOjWQuNYMEZliBwqL+qXquFXrQpmCDn4jz+1+wpqCaYhElesYtirxALdkHbFqdtSqxldwbHyBhIGnd0mN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZI1iTMIF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hNIN4oGb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZI1iTMIF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hNIN4oGb"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NFFdwZ179321
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 18:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H97jdc53rsSV9J1bHg93erHFl20K7pFWAZodpNuOJ0k=; b=ZI1iTMIFBVS7Mulr
	Zghrm51CWEAI8iqXz2kVEIz/mpxBfXbLdNPVHx05MOyM508eF0s7BjF3IMUn6Hea
	FpquPQ8eOV2Y7rP4C9uH1OBbDjcBLlHUAl22LeJXgmtt2QbXs/3YOdVkao9U9+Ee
	K2BCLWzwMVBFIK5EXTVgzp49Cg9/ad6TJRtCTs0EtX2J+SlZY7xHEeQ0pP8K2Dn6
	7iGEHE7lc7lu5GffeB7kcR+a8ADWbuLsQEATWogxhtT/mOLqJtt0GZgAQlgH9ae9
	JdlXZeghyQ//3kXDeu8LNo55T09cqL0nfod/93UBAu23E+J5Rql2vD7nymGdBcLp
	IWK7Tw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqe62jv9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 18:01:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0ba59a830so10926544eec.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776967263; x=1777572063; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H97jdc53rsSV9J1bHg93erHFl20K7pFWAZodpNuOJ0k=;
        b=hNIN4oGbzQV+nKY9jnMkV57nNBrQ9STABhpdADrJ8w82Nv5zuyGCXTbA4UGPOeofcx
         k9meXziqYRgpiggeD87jzkkn1Ol2qxsUmA95VaqfkdopK7g0o1mvFfZ3bTMHM4T2K8Qk
         nJtZOSXty71ucjg2dLHwSCnazdRIcEn5zeGVl/dr+XGDS02nU2RVmi8OYgzC1U0Lh91z
         IDxtCoJScoktEJpTz+/Nbim0BbOlW+INJBlU0aeBC/A29wg2m+NBFUlaeA+zwJb9Z12p
         E9rpSMsLbhsbOt31boJjRCOMN/4Qnm1TYc/MLLQrMMB2mrtdFxuoBL2Zn53DB92q4cx4
         VQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967263; x=1777572063;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H97jdc53rsSV9J1bHg93erHFl20K7pFWAZodpNuOJ0k=;
        b=VnjG5ayNPEg2jZ5t+pC+m4SGSOvtcJiDM4Q5NLc5ZrIVxHDlzdXK3L0MYUA9uL7yB+
         JXp0A+KKLlm2VJCUd7Itfmzf17grem5oAO2mUOzlsUzrp4u4GI0RK9KQ42aDscVS70RR
         RpMlZIPkb3YJNYG56XOjEKTsYeONTRfSAxBqv56SBZtaQ9Qi67CiBVRKXR2kBdAIDQh6
         eXPFXl7R1u0tYImthxjAWCPgOkPAa3qewyRhg3e1KMH4bsmAXQUiVgvWpqaL6c6AaAEN
         Jq0OkosHh4uQV08gSxFcK096SaeqtyCEMJndi3gld9bZogC8ygJy/ASJYXvxmFy97pEi
         O6dQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7ABsER6J5hzqBc9vgNxEDvwOd29P0OHvD5PvGAVuzJiTZ0MatM8+TUPeeNc9uNzmRnXVggW0bJo+kn5RwnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyrg6GozeFRNTqXMi0Rm1CK3MXWN6sS6BfF9wxS37gTcNNzwB3T
	HS4HASts1OwAXhZ5AWu/LWrko0DN8kJh1BwpXy1kk2MqJUBhGa27GvtrugSYG97xMzSgj01TcUu
	FME3EwOGytCJt+xSWwP5+R5lcO+FtXJ4J9H3lvOtOy3gTTRpfckpuhlGZVMmFBzN2F9wyVg==
X-Gm-Gg: AeBDiesJoAmphQ0CV15MlKT8H5I+IKc5jshJ17PZydvYjVzmMSGEDq6Lydo48JsFBmZ
	yBlIJYi1YWmeaWaIbnwOdpYsqjOluOtjWFoGAeriJ91hnBvyWBBp+nskhD1dvTHB1tFj02294JX
	sqY8bhnTJ42mZp+3NWaeseZonQHfB0gKFBC0k38RYd84s6etK9tnKcc/J/q1UdJpZA3Lsj87CiJ
	dqhdMPdgQK3MqZCo+EBwnbJ6qAgk73NvS2thh54jXaaDcs+Z1VgLumfdduFUCOasy+8YEM/g4+y
	ORG9wFMs2fIuDcfdkyzJ/oWdvr7K/GKo7fWJrI0Ap8CX8gVh9T4/c5PDVBnwzcSDUE3OQqGRV2V
	lvdSfXyQxMu0am4BNQnOpfDM06gH1cSkIoNp0kPHqsSfFGgUJs1N6NSMJZLQp42f99AnZ6z7ZNQ
	Z1JRsONdmd9VY=
X-Received: by 2002:a05:7300:7491:b0:2d6:4297:5fc7 with SMTP id 5a478bee46e88-2e4872fb657mr14968508eec.25.1776967262628;
        Thu, 23 Apr 2026 11:01:02 -0700 (PDT)
X-Received: by 2002:a05:7300:7491:b0:2d6:4297:5fc7 with SMTP id 5a478bee46e88-2e4872fb657mr14968475eec.25.1776967261658;
        Thu, 23 Apr 2026 11:01:01 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm27867887eec.2.2026.04.23.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:01:00 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        Yu-Hsiang Tseng <asas1asas200@gmail.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260422180814.1938317-1-asas1asas200@gmail.com>
References: <20260422180814.1938317-1-asas1asas200@gmail.com>
Subject: Re: [PATCH v3] wifi: ath12k: use lockdep_assert_in_rcu_read_lock()
 for RCU assertions
Message-Id: <177696726047.2493545.5792745669762197871.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 11:01:00 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: vwJ_LreA-KOwhpjParFiQzvGyqr7yUO-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3NSBTYWx0ZWRfX6dfbDJ3aByIw
 UluEN1VIBL8Q9HK0AnSNDyICcB5A06K2QCFNvQB6qO4G0Woc8brUy68Xxa9IM5g2rZRL7Dk1Eq0
 WId5uhTQ07AlGMr6r1ujzk/oA1cS1QXrPqTrpfMfdHM7jpwRaPENt1mdMiN6WD29R17eJdy9Mt4
 2YDOeaegZatreerWTs1z0k0ag5rNtjypUlStWxk0jv87cm3lfhf6Lk8ejCnJIeTEsXYyQ+xMn3u
 qd3Y5DZ8aj+Di3AY5lz2fiy5abIQSrcSBo0VoMPHxGeiRT95Qb+ZA57wp+wxTeITh351xenX/nw
 tkUaxE+ex6gxF23sXcb4xutAId7B2VEeQYXg5loktUy0pQUVhwUi7ywhAUCcO338rriEv3EIrZM
 /UI6YrXCVOm6EWAqF0t3XCgOqELywUv0BGgyRMJXMn8qq/dOyBncO+wahzRjqEW+4WC7x3PWLsR
 0nIcIcWihhjRFRGLKNw==
X-Proofpoint-ORIG-GUID: vwJ_LreA-KOwhpjParFiQzvGyqr7yUO-
X-Authority-Analysis: v=2.4 cv=Nv7htcdJ c=1 sm=1 tr=0 ts=69ea5e5f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=XjcZkKkVyDdEEfN8XZIA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230175


On Thu, 23 Apr 2026 02:08:14 +0800, Yu-Hsiang Tseng wrote:
> Two functions in ath12k assert that the caller holds an RCU read lock:
> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
> 
>     WARN_ON(!rcu_read_lock_any_held());
> 
> On kernels using preemptible RCU (CONFIG_PREEMPT=y or CONFIG_PREEMPT_RT=y)
> without CONFIG_DEBUG_LOCK_ALLOC, this produces a false positive splat
> whenever these functions are invoked from paths that do hold the RCU
> read lock (e.g. firmware stats processing or mac80211 interface
> iteration).
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: use lockdep_assert_in_rcu_read_lock() for RCU assertions
      commit: 4498664e2d5888efabb96428196a926acdaa25ed

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

