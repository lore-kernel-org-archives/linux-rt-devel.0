Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1E363C64
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957891; cv=none; b=iwtEHoT/Lf+sGupGuZsMRPq75VcDYVVAmHEHWsfum2OwchsyKmmCH99Niz5PgUcicaRKdyMy1vSSEmlvQKSpoo3ZrXNPL32c28K58ba9VG8vElFoLaui/N8+iABD6Aq55AvCVGOEnqZq+ryheEBn8Uej2I2JrKOdSbEbZHqJvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957891; c=relaxed/simple;
	bh=8+QSjknPC9+Czt+clcDIZ9CC42/u62f9ZFheT3F/nLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnh9gcHQDOFPBC1llokazv2SwCyo9vClWMoAwGu/R/0qFm/xbCIYV/PJ54kD2QPEgJ/Z6XSutnVUUgZwHbmUtFjLBfKVz57MU0h8fUtDGu/Ea+ODRai/5wXzzv85PE0xipxTa68/lpTjHGRTaRoNE14MjgukycpULlQNYXfoUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ms53WFcl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQq6rIDr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ms53WFcl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQq6rIDr"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N94fCn2319291
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v9CDZxY+AicG+LQxv/gyUZ+B2R4sxcezOhmQw6qqkCI=; b=Ms53WFclO/JSYHXh
	G9H7c4JvTFg0mYB2H/YwEI+GFoa7f5nEaqHyaPo4mbb7M/jyNr71gBBfkTVx4iDo
	1CvJvQOfHP04DflpNRy46px1dhh99My050bRb5qJLyAG+4iozitW5YK/LSLjmlGh
	TMVFd649e51uyqyLlqIgjOcUGebRbMuPmSnp1qdW3KgvpfbgASBG7hKEqEbLUAnR
	4PMeeuW0kgmqZyZH3N3eYiKOtxNK0qsloxuM6gf4kcRj6H9WaXnBEGFd0Tz9Ltcr
	BoumYGhQBOW/ThliQKoToN+s+EgX5PXnmZ+t9wmApU70yKWDUTSnsM4q5gv4rolB
	+UmEyQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqgfssggm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 15:24:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2d889997495so16058558eec.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776957889; x=1777562689; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9CDZxY+AicG+LQxv/gyUZ+B2R4sxcezOhmQw6qqkCI=;
        b=SQq6rIDrtmlc84+WD9AOqn9kdY40i9fK1HIZqIG4NYtKYgavjO7L5IuILXG1kM7PH9
         c2cI+ItmdtTFdpeAdr03Wjt9CZbNoIA2znfCWsvNGPLUxqycLB8xyA1/s5Ajo60LCxG+
         3kYkioBQC0+0A3AoNNWvz2UOYN4a5HC/Mymzh+d0V8zmyU4FS37BUxVg1mCdfweb7AAK
         S1k87mkRF8S/fNrHL/2sQ/sgVcMK4QxAqvIYs0ra4D+LbIbL3iZvZbtT7nZ6MkUUCTMm
         DHCtdHmmGfHKTWUugeYmDl6RRJVDqhgzBtBnCn4rNn/PYyk0gSHgldL0XQeo6UE5AIug
         kkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957889; x=1777562689;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9CDZxY+AicG+LQxv/gyUZ+B2R4sxcezOhmQw6qqkCI=;
        b=b/CHk/NJBNLwV1hj3tc56tYEp2y7s+DReD/I8KoRgH28zI8Rg4opjsILo9E7TmGeXe
         hOwCib/Slj+w+jEXkRO9ia1Lf+/TKE1aVk3K84kw0q7svTx748oUEUmGGZJcRlWh4WK1
         hF5VeZsION+hqZXGVUWAydev0tnBagy9HZNu5ZHeIWP3xIl9eotVtUOyZEWHE2RO2Bf+
         iLj75tUJhAzcnXK6EMfIZEn8xBqm3369U36pY7eFotB6X3KU6C5+hhcp2Lms0sQS15sR
         xWHAYVi545tHXIFXUkF9FeTyXQHBCEqcqRiocMfrAfSxoTjasxTUcjz055J/7TiJ7A99
         65Jg==
X-Forwarded-Encrypted: i=1; AFNElJ8M8zF6BkhndhTcnPQ410fpfVLWmIDOPlcVW7DhFKCW40GK3Wfh+C5G8BGhxoCw9huJW+OWQf9+7LikXRmr+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz23Lgkn8fW9X0y9EYeXjCYIilLAev/TPY7XiakW/wbm95SUDeT
	fC7a/Qgnp1ftLgkPJoRWFtJ1aB743q+Z4av7J8LBJ0F43yxWbw8eTQt2Vpn02S+lnUzICONEywZ
	EUJl3sZrtOKgtVG4vWWEhuJFE38PGNKUeGrvgux9yMpYuDQgClodLg/zjpgJbGUmu04kUqw==
X-Gm-Gg: AeBDievMiU7vd5RnkxQ7C5ni01a0zlMHbQL/yW+zcWeYhG5FS7PPuf2JPf+USH7DVA2
	12kQyxsKrOvWO+44E75P/1g30MurKmLzKom03QuRNBkLQUFOs4s2/s/N+HjLbcwBWXnhybSolSB
	y6N1MHk3QOijOKHoqvuDjiEyPTGdvHl9sDazpJ0f/a8sMlwUdRaQOp0F2YsUXsfoV5HzGCwlnYV
	FQS4Dg/vmSQV+dJTFfDgqwOCWbje4yXtdv9WLY+36pkt9T+Vplk4nilUASUic2l2ToYRmF/je0I
	lQS9gwh5UXkKrxfJ6nA6HM9Zsk0q5uwvJc+4Offb4SnDY5jowtIkvzMPMqqGj9JZC9DLrVlg6Ue
	JbJY3+oyZ280p7u6TQtWNSLVYdkaT2IXK8yL+36A5AZCGM8etUIEy7FXz1VrnLWq2YPPqtk5Sys
	bt0PxhAByWBpFsqTiq
X-Received: by 2002:a05:7301:4593:b0:2da:10f0:a8de with SMTP id 5a478bee46e88-2e464db026fmr15176441eec.8.1776957888903;
        Thu, 23 Apr 2026 08:24:48 -0700 (PDT)
X-Received: by 2002:a05:7301:4593:b0:2da:10f0:a8de with SMTP id 5a478bee46e88-2e464db026fmr15176418eec.8.1776957888236;
        Thu, 23 Apr 2026 08:24:48 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e7025cf413sm23284279eec.15.2026.04.23.08.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 08:24:47 -0700 (PDT)
Message-ID: <caad3b9c-2c14-4e09-b8f8-840d2ec111be@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 08:24:46 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: use lockdep_assert_in_rcu_read_lock()
 for RCU assertions
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yu-Hsiang Tseng <asas1asas200@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260422180814.1938317-1-asas1asas200@gmail.com>
 <20260423063020.NAero6Rz@linutronix.de>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423063020.NAero6Rz@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 32sVC5BCAIFatHdOVR8HLnUT5ZuRVGC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1MiBTYWx0ZWRfXysFmHdo2BotR
 Byda9Y7Prekh6xRetlJS3e95LETcgwzbzdeStiHcBalukyPUNN45rHaQczoa9earAuSuqLWWm/c
 6VW8wj/V3SlgEJQ8U0KKLP350TOF8fhXARxb5j/zkRO8+jxP11VPVompH4mhbI0jSUIlWraW0lv
 smzB5up0yGPSBLQ64k5X7nxIRrfGrppBRqpEtUJl70o8LB+BfhjrmpPdYNwITns/c3AzAdGrwhB
 mniPi7qFS5h3DLRCiSxm4pHeNJbg33Ne/lyg2i/BCITHtjEPXzD7bOPMc2R+rtUJm1mY0nrAA2G
 3EmFB+oBqRu5UPznpup77jvn7/qIVSipdGYOS7JL/iXy6SSUFaq3UScVFGMZnTFg/jcSjeLTeYm
 kY59IuRGu+QzBpmJerkr93X9fC7/2C0nS5n/YI2omDjblZd59ltYZUuOy9qG9729UjROXRIvMU1
 rXPhNtIKzL2tageCuoQ==
X-Authority-Analysis: v=2.4 cv=AvbeGu9P c=1 sm=1 tr=0 ts=69ea39c1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=Neo_AiBHE1Wlc-BSriUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 32sVC5BCAIFatHdOVR8HLnUT5ZuRVGC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230152

On 4/22/2026 11:30 PM, Sebastian Andrzej Siewior wrote:
> On 2026-04-23 02:08:14 [+0800], Yu-Hsiang Tseng wrote:
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> This could written in plain english as in "Tested on …". Not sure what
> this "convention" is but anyway.

FYI this is a long-standing convention for the ath family of wifi drivers,
dating back to at least ath10k:

https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/submittingpatches.html#tested-on-tag
https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath11k/submittingpatches.html#tested-on-tag
https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath12k/submittingpatches.html#tested-on-tag

> 
> The change is okay.
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for your review!
/jeff

