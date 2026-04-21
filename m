Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35478359A90
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806846; cv=none; b=X2qYwtfi5VAbB38PDMJ5ppGuYkZp064eNaxLrdBzUiuVwZaJwpFutzUFoBW6v05GfEXuhsBCbP03dWB7FkpCtHoHZRCH/7uWn1yM95rUPYyaDVXrggzQ/zUtlpzibB3lsnbZQf8AiOBPhyIhWCh7aAm4ZMIZL20TYOr4EjHtlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806846; c=relaxed/simple;
	bh=8Gl08ANzTWsL2G8lC9gTgFCAxl1aQw8Mj3W3CZIfLvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWHzizzmkK4XxADa00WPezJCF/6Y55+nP6uYHwxbhsnzb2u+DWkW+jFSLxkcpQREBOwC5fCLlcCTQx4hGV2v7NHMZIOsjVN8dD3WaFFRj+TS4I7n4a9RpPh8XNnN6tXvBT7cwaB4q07ygNj12OOTPKNroXVt47UCQnIMFpXWSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ktlLc7Xc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aIAP9l9r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ktlLc7Xc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aIAP9l9r"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZhoU976182
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 21:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c8pp1RE019uS7wcr5tEGYa5lrrV0sEz4reE3w0DGdmA=; b=ktlLc7Xc+EABsnHD
	qhIh+BNaS0XkZTsMS+D99+jghplovGzFe1cAlk+igFFv9yU3tjOj35xZxp4pc3rc
	8o32ywNHdW0nAfcUDa/8jZw83OJWc4el+ehte5nwqEZgkZEk0xbtZjDTlu4eROoW
	il5tMi4cbbEB2pexVgCbryPPZr/Kmccely7f/TFqlB6INkhXnHinQCxir+hhlZ0t
	QW7PgyfqxfGv6z2RizFZuV8s6OK18CxLq1NRXlG/mL7zAcgh+s4U+XQ3CBiZvlAj
	S8M9JVrqWU/JlSUW9OdlXmN4vKSsGSeM0pLZT4vUj/FLxdegzys6Nm5V3rYjFYCO
	vO7rEw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpene8gk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 21:27:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c8de02a4dso31579c88.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 21 Apr 2026 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776806844; x=1777411644; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8pp1RE019uS7wcr5tEGYa5lrrV0sEz4reE3w0DGdmA=;
        b=aIAP9l9rJ/yBe7O2zW35t6z2bKyLlPblzEu1M6OdOPL+0SOZoCx46oGwosFoIliOuY
         A6M9V8IUD4Sa8J9HH4LwGQGAPgM3F7PVedwKpoO/cPT8oeey29l0vdMpAMHkW4VY58hk
         iNZNq6WxyZcF59GcD7W8YPsijv9RY+OoXzadiRpTEQm7GepHjblJVwF1lLMH5hZxXPTq
         afMH/UkeRS+gcmzMbyuNhAJ1DpC2yOGLFKw9KNeR1rTYa/9/PEDNOWmJ078IIlmzu2nq
         POb50x+sxNtlggMstfWC6nTo+MdzdRsCJbRO9DxCaS5/5JEBAxKnHIQDYkPU82/Bh4JC
         Dh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776806844; x=1777411644;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8pp1RE019uS7wcr5tEGYa5lrrV0sEz4reE3w0DGdmA=;
        b=QLQyh5C8CXxtqWI2V2KO3ZGUNL3xqodNPDEMIAaV2PsimQ1TeD6AS20Su3sgbEemDM
         zz3RYNUx04Nfd9zQg7iCx1iQEoxQx8sGFWo2/kr8bn3KCh0UPGSxACKt0VhP2/zQ72xP
         Thf0liM5PQUMqnRjx9Pk1atrY2QO9l0agf+h3I1uSw4drseAo7CZmsIluIdJZ6HcuBya
         bVtCk0TezSTgkVeYbU50nJ4/stWsBnwnjMy13ObVfyf8SmEPznD9eiYR2T+ABCoF39uP
         hWr68c+V+xxYC8TFMtALJ4poIHSgOOiE4EatjaLE1ovmzM1CD8t1qXxo1g7939SO+5aL
         4wVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XTwYdV6pX7fzuk0Zzd789MsbpezQoXVbNF9hz60eQHqWHaoKxLNOZF2ecTJ6zvdrMqUmat7kp8DW7f+9reA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGrA8QiGsjS6kQz5NfNwHYblr7kKeh7tf15AWCZFFT4htenBda
	JBXyCfkNmLU+ltBaCrfpYQ1o8+TmclSJuVBAd70CN6b1LjM+cuZD2n7tyN5IxnRwPXB7MKU3577
	fR3la8WskjHBgVO65xRfsR01e+9zmdu5lrH9KvEZ2/wEkiYOgeelGgOBGFW7DdzLjwONMig==
X-Gm-Gg: AeBDieuN87pNDxxvpOvTjhxGiytEvjlixc3ZfJFUvAJeT4KeLGKwOsoVLz6WvufzsMi
	801ThoMEsoOi0IXAhCFsXtnSW5bKfGJr2l4h6Yrwe2XTgk5BDpXhy6uUxP96I6VLo6QEzqMkqPy
	JuF7PP1N30AQQFLQR6c9wu9rIZCK+3LrYDKUhCpzAQpFSGLinq5HlrM8334sEyI23P5eAm+qG0J
	a0ZyhEPvlDM/352t+aqcpWeS5/SAkJFTTVxjCdk/Y1S4Bo3pMM1GMTWKrw2uYJq9+Alat3wZzwa
	H/jOvxgQgqua5k+vhEn+Pv0HP44Mk4fEC/KmuMDUwwiwZBWnmgDoFrrWs1DGqXMv04GjsAcJeZS
	nOgL6lIK471oZSUb2xFId2iziaBtutQijBIzfI29HUKD9xeGagx9CtTIEiTQgyItEAeVsf8XbDu
	BbTdU5oYLcvRSgEmxwtYwTvIUw
X-Received: by 2002:a05:7022:502:b0:12a:713b:896a with SMTP id a92af1059eb24-12c73f92f99mr12165259c88.17.1776806843657;
        Tue, 21 Apr 2026 14:27:23 -0700 (PDT)
X-Received: by 2002:a05:7022:502:b0:12a:713b:896a with SMTP id a92af1059eb24-12c73f92f99mr12165212c88.17.1776806842907;
        Tue, 21 Apr 2026 14:27:22 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm11400458c88.1.2026.04.21.14.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 14:27:22 -0700 (PDT)
Message-ID: <a396cf77-81ff-45a7-ae62-fb4e22c18497@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 14:27:20 -0700
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
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
 <20260421172500.1050754-1-asas1asas200@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260421172500.1050754-1-asas1asas200@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIxMyBTYWx0ZWRfX2uvSPZUMJZY6
 bGvvWnGRE6U9eEPpS0eYxcqhpDMrNoHfxjVQmToqflH/pHYDKMPjteRaQCzjAmNWg3EShX3P35w
 gXEkLBuWt0RJzHwD+pFZZp6zx7FzyLJi/bx2PituziUvuqOt0Sg8EJgdonGACKZ14j6JBgLznsm
 uP4j89oy9ZRwrb1qSJahK9l2Q7IyR9pJwW9zJTOK4+ep80gJj7+HIIzkbvK/YK4y+j5dcGbJnSc
 iw8L4V3ug6oLwu36pwxeroyxZ8mp6iIFC3UR0ZI8XiM/HLGzns95QImIWT/fk5kMmaaov4MuKHv
 mc2L1sLMETwOqQNzo1YKfjegCYQRWApu7OjBtFd9RTAw8SGmBRjp2Pf6yLYt6GiDhJvX8/WDcTi
 lEqXP6IJyjuSWcF7UOD1miCH0cfPIfardQ+x419kypv3/C8BfyRUz7N5qUehxioch9cCxYrgari
 IpRjYAdGM1OnbtlN+TA==
X-Proofpoint-GUID: H_Ri4S7BHVhUj6ddhh8MOIKmgQ6eMEBl
X-Proofpoint-ORIG-GUID: H_Ri4S7BHVhUj6ddhh8MOIKmgQ6eMEBl
X-Authority-Analysis: v=2.4 cv=RoT16imK c=1 sm=1 tr=0 ts=69e7ebbc cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=b7LFBttVh2RoOqfkFZAA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604210213

On 4/21/2026 10:25 AM, Yu-Hsiang Tseng wrote:
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

Note that Tested-on: is not a official upstream tag, it is an ath-specific
tag. Since it is not an official tag, it should be specified separately from
the official tags:

<commit text>
<blank line>
Tested-on: ...
<blank line>
<official upstream tags>
Signed-off-by: ...

Unless there are are other review comments there is no need to send a v3 to
address this -- I can make this change when I pick up the patch.

> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Yu-Hsiang Tseng <asas1asas200@gmail.com>
> ---
> Changes in v2:
>   - Also fix the same WARN_ON() in ath12k_p2p_noa_update_vdev_iter()
>     (suggested by Baochen Qiang)
>   - Update commit message to cover both call sites

Note that you made v2 In-reply-to the v1 patch. In kernel.org code review that
is NOT preferred. In kernel.org it is preferred that each version of a patch
be a separate thread.

> 
> Link to v1: https://lore.kernel.org/ath12k/20260420161049.695518-1-asas1asas200@gmail.com/
> 
>  drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>  drivers/net/wireless/ath/ath12k/p2p.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
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
>  	arvif_iter.vdev_id = vdev_id;
>  	arvif_iter.ar = ar;
>  
> diff --git a/drivers/net/wireless/ath/ath12k/p2p.c b/drivers/net/wireless/ath/ath12k/p2p.c
> index 59589748f1a8..caa92612372b 100644
> --- a/drivers/net/wireless/ath/ath12k/p2p.c
> +++ b/drivers/net/wireless/ath/ath12k/p2p.c
> @@ -123,7 +123,8 @@ static void ath12k_p2p_noa_update_vdev_iter(void *data, u8 *mac,
>  	struct ath12k_p2p_noa_arg *arg = data;
>  	struct ath12k_link_vif *arvif;
>  
> -	WARN_ON(!rcu_read_lock_any_held());
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
> +			 "RCU read lock not held");
>  	arvif = &ahvif->deflink;
>  	if (!arvif->is_created || arvif->ar != arg->ar || arvif->vdev_id != arg->vdev_id)
>  		return;

