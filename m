Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE021459FA
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776738285; cv=none; b=CQl9C5fjdPkxIvWpFBmhHEkDRGjisEGQKsZiGuQzUDX0PibrZ6K1bN2qj1ItsRSQiCHt0TbtcXwsIMD9KXG9AZjTx3oOMWogd+tLSpbdIVM0OfxCVvk6obSeKx3SozCkmAr06zopkBW54Hh4e/43qt2F4NBTkgYcal9wmohYK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776738285; c=relaxed/simple;
	bh=YNb2SFORlhn/YxpS0j4l5RbZpApHeHgTwyLgZgxkwK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipB0ysSYvmznZ8FZgXiViQXMOtg/bWsr4hyK1tetFytZoB5NLDZn7tpSw9Nd66Cz+orO+snJ0PWRFApTBaGijx2BYS4iD9YTRU2CuVb165BEHE2PffIsPzy9ci1wMSF8Q5GGwVwNV6DvEAmQCMTun4oUmIIlTGLy0bapNJSRhc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXGMutNI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ebCYntMq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXGMutNI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ebCYntMq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L1IWO01601031
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 02:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kgDMVNCvXyKwwDfZlNFHIyKphSpxFtsaHkDWCwFQFHo=; b=XXGMutNId1A4XRpO
	h8g7wY+s0r/8gVyvi8Xh8E1wmNaLJibCWqnHY4FP8zLk/zy3rJuyfkK5fM0oDacZ
	T+1DQcrrrkdzIyO+85TrSbGMmBfXclWK9m1vznJeYalN1D3plaj2vkSPn3slVxTx
	ofq3O+AsSP9XIgHR8TiUIN6cHFLWx8Zg5vbCXT1NbQvljaCAf9RPXcXRIE36kghP
	r03WOddszcqoqQsB17qiLK4RZOu0QC/YWpc1WYgatDyNeLN26aQaO0biJegqSwSf
	COAaoZPr4hqWqQ8ZniXJQfCtwgqsCRW51AQ+81fLHMm6sXDN6JsRkpjy4wVe6Hvh
	feU92Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh89baj2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 02:24:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35e56ed5d5bso5352680a91.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 20 Apr 2026 19:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776738281; x=1777343081; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgDMVNCvXyKwwDfZlNFHIyKphSpxFtsaHkDWCwFQFHo=;
        b=ebCYntMq3Ku+tlxvITa9MiJpgAh4RMGhrWKfAW8nrgzn+1nP1q1iP9/p000oi1bQXS
         XynfPk/Md0EKoZU5Z9XxmQSl326BhSUuZSmC6mwDoOh8lHNBo8k9ZWSUDSqXWSZ99Ifw
         g/O/kEjJT6+XB+tHqLh4IgwLbK7Q2Kis5GjPTHb1uuFaEu1IXy8F/CZtSbEq6nSoyF8f
         DuUfLgZkbH+nAPlQRYQ4jasDMI3KBJNDJ0+bj2J4pxEhY0gRzid27v5eYcK+53q1kH3D
         PFwQ5waJr8MwqKQHTgoKwYftevjkvdv/JMECxPCJNfW5aLGXahZeCQLorzlZD7OwabUu
         GB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738281; x=1777343081;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgDMVNCvXyKwwDfZlNFHIyKphSpxFtsaHkDWCwFQFHo=;
        b=dr1TCS3I2K6/fOyYpyVghQInVpVTTANc8e/TtbODKCPqBCTeYh5hPpMqdHdwk494Mj
         69SvDBytEqwgpxYMHwvcqU/+sLcF9b+hxUp4Yh0YUOYbKQWd2mXTa23n+6cg4Y/gQyaV
         2aYSviypHCm/SyCbT1h8vRgRF9Agj2wzZJBK2wwfLu+q3BlLym2bIC7tVCph+RAA2xMD
         mZcYmZq+6YkA+f1bKigIXN7ACUzGcpysooDz5J8uoxxwe3nSyyAIb3qXGMVaqjTgag8U
         +aA8uIJK/YZMYKvxxC7j1jBRbn2gj8SXO0de2s1F/JAr3ODOIeVeLMdg+VdoJPLTcVpX
         D/eg==
X-Forwarded-Encrypted: i=1; AFNElJ+jKExxyBZQrM3udvW0rFASq4b1BO4tonA2aITEHIdSe9Obrc6kdkmqSSQBuD3bnkASMk92xbKWG8TwIYdn7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YydLtf9wl5eRpFldF21QYayYJm8T2RG1tP1QH2fam+7PW4mGq2h
	Z4YGJ+v0EIzSF/Vpyv+s9DbkIhznhF1OfywCxs3YbDDOHfEMoihb142TFfL6625uCqsTQR15ARK
	+C6HdpgyZlv66OruAlBgh3BMEp/x2EFehilmnEK2y3ju4dBkDi9/MOCZRiyPzs5NxKLtUuw==
X-Gm-Gg: AeBDiesEQMkbcoq50pfGVjdMmNkvNn9YeZFEcTp2JAXaJY3RcO/jw+z9sDrwFB+CRXQ
	mm/flqFUdZLv6yl5dIdtaP6YonJNmw6ruCnQ6UH4N9UpGnYCIi3A0tMAjafG2VQj8/QOX0ulwtj
	XChNaS8REPVXf8ea2HNjYFcw/DUinT/CvXwh9bz5elkx+jqx1DXZ7qiz537roIkExExzXuvcHwI
	bGME2rygGnim4U4J3yXkKBBMi53ZF6nm4pzqRguJ3/RC+Wu6lcaj8znKfIrxshVTP2/mrV9pV4l
	YXVXmRImS0laeQz23z8Ni6In5lxG3KERkyPMNmp3fuOt9uigT7AsLfuJtSavZcuYpbdo4A/oJbd
	Op9RhuiY2nL63tyPziYJYgyX0Z3NH/dZmKCQCLjKjkA2+QpLjxgqTTxfMUfm87h9QMhR++3chs6
	dIPfivZCGv5Hl0RplT4YSECEZTv/HFLg==
X-Received: by 2002:a17:90a:d604:b0:35b:952c:43ab with SMTP id 98e67ed59e1d1-361401eb6e8mr11315825a91.4.1776738281303;
        Mon, 20 Apr 2026 19:24:41 -0700 (PDT)
X-Received: by 2002:a17:90a:d604:b0:35b:952c:43ab with SMTP id 98e67ed59e1d1-361401eb6e8mr11315799a91.4.1776738280743;
        Mon, 20 Apr 2026 19:24:40 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc593bsm14924248a91.1.2026.04.20.19.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 19:24:40 -0700 (PDT)
Message-ID: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 10:24:36 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix false positive RCU warning on
 PREEMPT_RT
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org
Cc: Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260420161049.695518-1-asas1asas200@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260420161049.695518-1-asas1asas200@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAyMSBTYWx0ZWRfX4nalhTARealp
 1v7cnOf8oAKPXK1SIalzWmRqI4IDJFnr6zCqMRpWvKewQMqIa/DzfH8Qx0DDgtN36Iymy7Xmuf5
 bId8ClilkJ58eGMK/D+ZOl3k0CPwLIBcWEmt6U7kPIvttAj+SAmXqZJscj+rNnpKdgtpb/RPTV7
 ECn//xWFkkzahZ7hnsZu8g3Te5Qra9Njhuzma+wsXlf7c6ABeawplYNiqhR3vxl+mzGuyioU+bR
 BxFqOoSBoZQlad+0dbRaNngJqKP8cM8ZuZIj5NeocdG6xyilk/CdPEHBC6ie1TYklGHhneGQpC4
 u3MZpUEjlCpeMgCYRJWs6Jy90GjoradJNJDdhFDpHi0PWNZNcd41AsDuaP2qb2Wd7PdqfM0NIsc
 0AabpqPKJeXVoQP9T2o9s/uCLfKch+nSB4/VK6YlkbsNTDQDX7t6We0gnRRgLV1t6+yHjaVaCEQ
 i7s0RW7LxSkA1u2O5vA==
X-Authority-Analysis: v=2.4 cv=D6B37PRj c=1 sm=1 tr=0 ts=69e6dfea cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=yypq-u40hovQB3Eki34A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: KOncwCBV9a0nXjYA15P9tesA6gVhkoYp
X-Proofpoint-GUID: KOncwCBV9a0nXjYA15P9tesA6gVhkoYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210021



On 4/21/2026 12:10 AM, Yu-Hsiang Tseng wrote:
> ath12k_mac_get_arvif() asserts that the caller holds an RCU read lock:
> 
>     WARN_ON(!rcu_read_lock_any_held());
> 
> On PREEMPT_RT kernels built with CONFIG_PROVE_RCU=n, this produces a
> false positive splat whenever firmware stats events are processed,
> even though the caller does hold the RCU read lock.
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
>   - ath12k_wmi_tlv_rssi_chain_parse() holds the RCU read lock via
>     guard(rcu)() before calling ath12k_mac_get_arvif(), so the
>     warning is incorrect.
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
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index fbdfe6424fd7..a772a5b6adc9 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -788,7 +788,8 @@ struct ath12k_link_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id)
>  
>  	/* To use the arvif returned, caller must have held rcu read lock.
>  	 */
> -	WARN_ON(!rcu_read_lock_any_held());
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
> +			 "RCU read lock not held");

should the instance in ath12k_p2p_noa_update_vdev_iter() also need to be replaced?

>  	arvif_iter.vdev_id = vdev_id;
>  	arvif_iter.ar = ar;
>  

