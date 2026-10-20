Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476509;
	b=4CBJIDcEdV0IUvf3mnACU+ac1czZHVzZpy3o97w172A/8fTk+Ucr0MYnsOS8/3wo1fY5
	 Sk7+SvL9lqpqOcvTRIk6+Ud5cmcqnpm1AJ7H053dVlXjj3Z14fbgUxVXAgBVCH/AZkTYP
	 6u4vGppLtu6+0QvObVrzTyYvFPcg2qVrMemEz0MgcebY0VM19tLeFMb1fBBEIgqesadxE
	 iGGakmLbeFQOdRZTu4oJdcjfF4JjKr15/5GAfe7DIkAkrmQew0cB6XBc5y0vu2aPEwekZ
	 D3NLCIS+VyJW3BvF79/gVt3DcrQpVEPK6e3kymDzsmcYfBhyObSFnCrSE3o5fbiZlEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476509;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RuGTKT445WrPldWKL7+sx+NqLoh9ybwVXtendG+9yeY=;
	b=yv8Edb548IpHePpra4KOxt6lyVwmxl9qnGqNpPO4xtDDjlM1YA78wyrv4+sqVyWkOKj1
	 TCpP69XdNCRCkagHhrbQCymuLml6VxHAE6SJncMzjL8GX2WtDsDjJWL3c5e8xIi0GHazA
	 73bebjOeTIxigXDSh6fr5ppnaVVMVL0v7HH2Z926UNOtmGMonWbd/XPPGgDTzJv/hQkiu
	 uAqPpi49CZowCwLgXQQldpOo32e6QOFH8H/7yzyZQQFxjZeu5Kce83l9kbulIhfwuR0WJ
	 sIytwvlivjI3JV9K4AFMbCy+3cawpPGFWgL6CSlf3/F9rtyPzgHdBA3mvAxgAd58N6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fNVBD8bQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bmv7qK2s;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A76606A31B
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 06:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A76606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fNVBD8bQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bmv7qK2s
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0tVkF4178316
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 06:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RuGTKT445WrPldWKL7+sx+NqLoh9ybwVXtendG+9yeY=; b=fNVBD8bQd1vvR7NG
	ppkIpg/b7chIA73L9syfO1/5Fhhutg+6z5XNeHAL4ME/Qcw67MHjmq8WUk/IAsT6
	hWOcRcXkVEeVxDPX0wf/JniBKbO7WvKyyFJjxHr4v9ABvk6HhSRBOXpDzgNQSysB
	wiD+DX2y0lvfWn4ugW3+wCMmg+1aeMMJ7Pz4TIYnY0MUIOQIjVSYtUtG8r1OrRhm
	dzAdp/dHOTaJ4e0U9Uk8NBehdjRssbp8d6V4ySQB2GYAPZY/c1IUtdUsp/A9MK6E
	N4WzIe1YFW/LCEWBBJ+FX5X5n3CTevWmeaLdy/YDz0mj5LIpLCv6f12Q1VT4+8J4
	jlbBiQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n12vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 06:08:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92eebb130dcso66559685a.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792476507; x=1793081307; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuGTKT445WrPldWKL7+sx+NqLoh9ybwVXtendG+9yeY=;
        b=bmv7qK2swiH9OCVIMnaz1iQEieQMalwodn6KFEt80kfxzpMCTzI7w0fVjA9NJfDwVP
         K9F6rAeXCVf6n3ZhvvAX+wn9M27gifMr7vAUy3SWWkmY/8r6bIdOfnOQd6+02fGBIRbe
         nC7CQ3CaFk7GniUwc2gItQk24sBkPpwnTsvTeryWmG5BGR6wYCZDqFssyXGyeVc/lTST
         ixPGlT9qGWbE9d97YGL66m8Xk0IXMQf+K1PQsaMvEpWKyM+ZOVbSsMQhzmlrkh4AC2xA
         eigJRne4e2wF2jjgmWxjAUlud6C/Po/ODnYp2S6e0I7FjaWtod4i7Hjei6C8FlyKDrkX
         5ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792476507; x=1793081307;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RuGTKT445WrPldWKL7+sx+NqLoh9ybwVXtendG+9yeY=;
        b=Ax1r6Qxw0Rl/QDaSWjzqhKMe+CR5qxBFqcFRX9RMd1h+je4Nn1ga8wtMDLJinTaCiv
         a+26cJen8M6AjvBPfSRuyCUGg5qJimRnVKKAWZ+E2i10SiEePeklT+t7/2Zu+wZfWntA
         EZo0MxqpuaGftbYo9K6tpIyBQN5rfejbpRm+LNCVKA39m0yRdT03Zfm3Y7zJ/lk7Lj33
         rlo0UAGG2HpbDpNCiuvCgd3C4BpeQTxjhzXpdIfLaFRv3nWiInMddaaITpfKk2xpmOcM
         6Bf1kisEhPG+/Ax9ZACXkPmu2VViUrkpvaidY35Y4P628s08DYddo+P/RRaEgdaueEiv
         pSoQ==
X-Forwarded-Encrypted: i=1; AKwUvByUX+frG0o7C65eDvLVfH7g/8CRt6F1zkkdIOgK2iEs7nv78SOv+mQJuFQO89b3Hmds7KFgbkw0pPNpovlc2g==@lists.linux.dev
X-Gm-Message-State: AFq9FYL7gokICiA27kOVIowsGq7NE9VYXgL0O+4s9XKqBBEXCqJ0MZ6e
	7xgbPD8zVPnzuxvhh73KHB890HIYWlzGzRRNCpqSAo4I+uRDn3x0j1kbjFDpVNbBPhyIQYzWefw
	cf3JEo19xZ8ZnoVmkqL2ITwgR2oswjcB0FQpHSqp6tM6pkrrzDJFsLljOKbK36PojkmuwOQ==
X-Gm-Gg: AYBFou1+r+ZN5Dd0dtzzZs2C1EpJyziUwH1LXDykDRLAKlGFKu6wBnmsTGh0Mr3Jk04
	Lh6mDO+bz307LUmkVkNZ7bN1msiB4/h13FlccD9LKEnk4feGqvnxYoDln/2krjA4q8pbh/jVnCR
	xdTwL0MUkLuQVAXme5xeRqhs4+LxPB07QxVb/k4/FxyVZpYU+wU9UHTn7QeOXRBa95sWoMYoSGP
	J6jcOn8tIXys4jKuC1/kTY3GcGQQrcGMk145vPHBGpuOlS5jeMAlLz0Sjx5gyu3A/o60KYGF83T
	923N7e19eG7sn1fLqwtsxehN4rIhzjfnbg70KvcuQVh7aUqNeyiPxa7ylls9XtfTHT4+DACaIdS
	PyLCeFD999hpoizbk8WEl7w==
X-Received: by 2002:a05:620a:3711:b0:93e:6d87:4f69 with SMTP id af79cd13be357-93f29c95919mr1911840185a.3.1792476506750;
        Mon, 19 Oct 2026 23:08:26 -0700 (PDT)
X-Received: by 2002:a05:620a:3711:b0:93e:6d87:4f69 with SMTP id af79cd13be357-93f29c95919mr1911836485a.3.1792476506224;
        Mon, 19 Oct 2026 23:08:26 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b3cd39ec18sm2243135a12.16.2026.10.19.23.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 23:08:25 -0700 (PDT)
Message-ID: <74dc9718-9911-4a13-9e10-0c2932007a4a@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 08:08:22 +0200
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] regulator: qcom_spmi: don't take a sleeping lock in
 the SAW IPI
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ilia Lin <ilialin@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
References: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
 <20261019-fix-qcom-saw-v1-3-9c7ba3fc2493@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-fix-qcom-saw-v1-3-9c7ba3fc2493@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cdzsfEnAntW-AYHp--ZBjo0PbTl00CtH
X-Proofpoint-ORIG-GUID: cdzsfEnAntW-AYHp--ZBjo0PbTl00CtH
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad7055b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zBMmP5lLP3iSaWE8ja4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyNCBTYWx0ZWRfXxU0DPtKh8hWG
 joBElFLJCxPx7dJ++sQryo0vyamqY4fo3t0NPWACY4JJTsN/lExy6Q45OpUrOpJT4Eg+4Vid+tN
 epTlbYAzNCdzTQf0BwwKQdm+tnon4mFUqzWiWdhkHN5G5uB4jO2DbOx+JU1tGOK7Hey5Pbxa0Sc
 j3VGJHTiE5VP2WgpKGOx/V9zttv9qH8RlIElIV/W8d8r3QiSI9hT8YgrgCDjHSje7Vxq4qB2UXY
 wMWdZLIg8059WHUFTlttHe8I4+dtsvljq2tvaRlvAN+rpQK+XJ5gMmvsxqpvmZ/NcRB9EX6sa7K
 9N8NV4b+zAuTE4NUVPeyPEjUQcwTjYObame7sEGWU1UFZ7ncWZu91atpO0CMH5XGtuvk/x/KoNN
 jSyX75+O2Ewk7K4z9NtWCEBH0L2CClUcj1wUlW2ChJRL6jeI33ntZd4Zwi9VYshXuT+EALMryqz
 HFbJsmGs1mVtOdlJvcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyNCBTYWx0ZWRfXzSGBJfGLDGZe
 ERqfwhD7eX2N9w29Mgfyzdny3pxqvs9fHk3+Vl0+dCffS4iFIsozB84uURv7zgQtXNSaFylkiV0
 A8s/szSZthXAIpAq+Uvm8ln/d4GVM74=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200024

On 10/19/26 4:39 PM, Dmitry Baryshkov wrote:
> The SAW voltage change runs on CPU 0 from an IPI, but it reaches the SAW
> registers through the syscon regmap, which is protected by a spinlock_t.
> That is a sleeping lock on PREEMPT_RT, and lockdep complains as soon as
> VDD_APCC actually changes voltage:

The SAW handling barely belongs in that driver to be honest.. but
separating it out would make a mess out of sharing the of_node

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
