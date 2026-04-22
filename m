Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A082D8DB0
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823593; cv=none; b=WqHCbsufwVqCrwgpvcu45HnG97vnh2Zpijtf2Jq5T/Q4AqaJYGONY8vsdbHqeK9IQUM0EnxddauOHcH1Lr/WIwQZacgA1/vWn0RartUbSp8wODT9O1ng0ZEgcH/2mCuzw/mhF8hKqeKfvPMS3u5QsfHwW6bVX9qAcB+w7CPOxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823593; c=relaxed/simple;
	bh=R/Iz2RAwQgHvZET6dqX5gNfKpOa1HfQw6wS8D/2b9rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDUFN8gYIFuJoH88xRe9qhrjlIhayGFqwxIMxofHuXev7j0iqRrv8AjiifpkonOuHHrkC470xZIAYwLRklTyzrcDDD/JRF3HKYO+ACeI7Vm5JTFfZtF5EwCkbuThc3ojdAz8cZaLHilceU2VcjpAAkQY2A07bEIyWPLzAzcv9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ls5H+sim; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCRXPECy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ls5H+sim";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCRXPECy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZnRW3377506
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 02:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CV7U3mQMJfVMAl6qflQ64fFOB5iGrhYZdBNtJgFLV5w=; b=ls5H+simo0txwsBu
	u3grL+mcbKlb9GCHvQwcJy/lXWGK7vb/JJtNAKMvkU2IrcIPPsBt/lQn8XBuuxK7
	2WbCVl3GYRKbImfHfhqKXf06Jxc2Ee6AZ66XxgCNfTyfvAABYCJQ/T9+EdtKjZ84
	QMtBBM54VAU9G+TmUBo1UmWvVqN32GKsmLxRDhp55M6c/qNuU4cmeEhA5tUZo9bb
	/hxIonzt6KFXtGmyi3Hs1yF0QnTE7m5kJd2CcNvAZGcIxtX50bXFeUiU6hY/hX7w
	+vvxN/zhB1cKwcuN+bnMCi2Kavo37ZMHd4GWrC+In8z3azBMEvh9lo+hIExHCZw1
	eieGOA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng186d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 02:06:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da86144daso4913954a91.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 19:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776823591; x=1777428391; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CV7U3mQMJfVMAl6qflQ64fFOB5iGrhYZdBNtJgFLV5w=;
        b=iCRXPECyi+AxxuvKajG3LtqcXL9ymNhJey2hBizPy4FwVFAR6Hna90OZk0HFIu5RCR
         yiVTgUDeBv1y17s4Cgjbh4kwQraFVq7C+Fe2xF/AtKddkkiXrG8fmXKnXwqvJmaAjwOJ
         Nq1g0A5sxrUaWJQcnhwMQAi+Pggjg4dRoabbwZ5obrVfM8z2eZCk9WhteJDE4sutMUK4
         KFQ6oPwadZYVrVa44Jd02KPsf7JBq0hKbt7FFFYZ37VzkGYf4rAa8UFhTnYbOua27Nf9
         FstDcZNd/eGhT7+YfoarnNxB0Xppx/fCTdoeBFH6H6cqgNGERgwacnapOEAIrknX4jXD
         u9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776823591; x=1777428391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CV7U3mQMJfVMAl6qflQ64fFOB5iGrhYZdBNtJgFLV5w=;
        b=jiUUeSVRws+U27bzPLupNIKLKhkAGPPnPEjfFGwEmWdcx4sBzvO9HDi+yokv6neMow
         H4T+E4J1VZBDx/cD56Al+HRYkk5t/Rchefi/0pAsG//jbHPp3ePsfEOc5D7MSMVdqxUi
         4mUlbZBQYgm7HHpcV9uwlf+Ilp4dHaMsux7NIIefs15oK9oHT5mDDsh3iESxTLglVN1o
         nedfZmwiLDLe22X9dvavZlMwLNkcbJ4Zf2EkbdJypBhXznWdVCAq7JGsnyj6IXaOoj+q
         i9855aJKnvKPMtL5lv5owb7YXzWRkXzLuzlHds3Mx2HCkYaGjjirNpb0wVUmS7WVw9Y9
         p4bw==
X-Forwarded-Encrypted: i=1; AFNElJ+uKHiEPJKlfYnbDcs9OjdDr0QcUDt6xJ1CqHbNAO6bAqyqOlo3kIhq/GgTi/ZOBOGfqoZlq0uOr/m2EP0tIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2vBwFb1XJveK/khFAjA8Wcl4MlXCbmBojL7+72ywlv+QhDzWb
	gZFOQ/hthKn2Js4joszXZBOJDqrTxIvPjW9AGvPZDURMwd86FyikdNPdcj+aTBiR2fm0mKUhIeK
	lt0slrj+Tw7vK6xG7tGRnuMVLK2a4rHafvzzAtGHj+3E7F+y1fnr+HYlUStACSwEhMSg0kw==
X-Gm-Gg: AeBDiev7vKt/yOCZYApkPVYBExRvgrH6hs//lHaTr/69MU6xTIfIchWzNIp//gvOePO
	agEE/G45kUQxWPQq70SfPm4930vEmOqsex2Cy6FVUrVqwIyKJ7NgbcQmv8/kkNW1Rf7ZomPBMk5
	6I9nr/3Zh7XXoFjUCSJ0KJs6e03yFgN38otGnyTH0Uhfxs9KtMIaLxTinRd8fnsp0D8QitNWbK7
	rngZka0IR0RHNfT3uNndy9rG86yO0wxrekdoHQuD4blleWLfPQiWbA+h0n/ZHlf1FLzz6VkADio
	Y/NTo5O8qw9O+EFg81qsz3kAkTUayQcfx6J78H2GjbC5LwQQ9Fg63fH2EbTzodyBE45d6TWNLZy
	eE6XFNm5I/X354RKpAODiGqyTukdAfVxhu3ireyY0jkLXU0G/laSNBv86JKkxNUuTC3Bz2q4zNC
	YpV1zOg4/Qu0mG9xC6TIr19IVLl0s3Vw==
X-Received: by 2002:a17:90b:4ccf:b0:35f:b647:d973 with SMTP id 98e67ed59e1d1-36140229b13mr20344547a91.0.1776823590607;
        Tue, 21 Apr 2026 19:06:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4ccf:b0:35f:b647:d973 with SMTP id 98e67ed59e1d1-36140229b13mr20344504a91.0.1776823590133;
        Tue, 21 Apr 2026 19:06:30 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614371a7c8sm14933809a91.5.2026.04.21.19.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 19:06:29 -0700 (PDT)
Message-ID: <dd79f106-9b68-4600-9094-d962e598199d@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 10:06:25 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on
 PREEMPT_RT
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org
Cc: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421172500.1050754-1-asas1asas200@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e82d27 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=CW9kBp-o2NpbEht7vlgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: MT6iGtedD3z-s5RGJDqfLfInAatLGAi-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxOSBTYWx0ZWRfXzraEovvCRt24
 Ch8BLwaM7Rx+FLMWRrlnQPT0lal5zmWPGGj7yYkBWNNccArNpJK0abLCugJzDApRVdluuRGcBG0
 gdTz5rtSkGvofJFp6+BVXGSmNmJzx4XRdjzKeq6D/1G2kQfmCq8j2ep2zUR2y7zxNVeRmA4ymn7
 LP22i5kUglvslH3WtKx6Xd96nlLPeyWqQdRZTw4XIwNLFxJdO+GGeTjLSKrb2D/edha9T3s2WSD
 pjd0hfDLOE0GgpCl3kHocFSr8jly5o1CqHBBRtRScSV5SCtktoliEv0wICmukv3UvN4qnLnyHyJ
 rnh0kZryUtP3NF3yoV9ZUUGYWKYekZdrY8AijrMSRpgem37w0yX6gOH9PCKhz8uztyHIYmGjCA5
 57usjaeY6HmzLy3UXh7cMFMgHDvT0NGXUANulEhM92AqCAlKfokBA1HJ+V3AniqgukhVOL5ByXI
 DIWwJTmsbLf+SAN0bTg==
X-Proofpoint-ORIG-GUID: MT6iGtedD3z-s5RGJDqfLfInAatLGAi-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220019



On 4/22/2026 1:25 AM, Yu-Hsiang Tseng wrote:
> Two functions in ath12k assert that the caller holds an RCU read lock:
> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
> 
>     WARN_ON(!rcu_read_lock_any_held());
> 
> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
> false positive splat whenever these functions are invoked from paths
> that do hold the RCU read lock (e.g. firmware stats processing or
> mac80211 interface iteration).
> 
> Root cause:
> 
>   - On !PROVE_RCU, rcu_read_lock_any_held() is a static inline that
>     returns !preemptible() as a proxy for "in an RCU read section".
> 
>   - On PREEMPT_RT, rcu_read_lock() does not disable preemption. A
>     task can therefore be preemptible while legitimately holding an
>     RCU read lock.
> 
>   - Callers such as ath12k_wmi_tlv_rssi_chain_parse() (via guard(rcu)())
>     and ieee80211_iterate_active_interfaces_atomic() do hold the RCU
>     read lock, so these warnings are incorrect.
> 
> Typical splat seen on a WCN7850 station with periodic fw stats
> processing:
> 
>   WARNING: drivers/net/wireless/ath/ath12k/mac.c:791 at
>     ath12k_mac_get_arvif+0x9e/0xd0 [ath12k]
>   Tainted: G W O 6.19.13-rt #1 PREEMPT_RT
>   Call Trace:
>    ath12k_wmi_tlv_rssi_chain_parse+0x69/0x170 [ath12k]
>    ath12k_wmi_tlv_iter+0x7f/0x120 [ath12k]
>    ath12k_wmi_tlv_fw_stats_parse+0x342/0x6b0 [ath12k]
>    ath12k_wmi_op_rx+0xe9e/0x3150 [ath12k]
>    ath12k_htc_rx_completion_handler+0x3df/0x5b0 [ath12k]
>    ath12k_ce_per_engine_service+0x325/0x3e0 [ath12k]
>    ath12k_pci_ce_workqueue+0x20/0x40 [ath12k]
> 
> Replace the WARN_ON() with RCU_LOCKDEP_WARN(), which is gated on
> debug_lockdep_rcu_enabled() and therefore compiles out entirely
> when PROVE_RCU is disabled. PROVE_RCU kernels continue to get the
> full lockdep-based check.
> 
> Fixes: 3dd2c68f206e ("wifi: ath12k: prepare vif data structure for MLO handling")
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

