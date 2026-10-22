Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792642370;
	b=HYgrkXdIDjqRevs2h0/ytstjq1HExW/rq7IvlKiYBJD2APJ70hLPPGNR4m2SEo0LWQT7
	 6PtvbIPFu1ZfxH0uRaH4rw/84SoAnfP8FGstbQ7WeFDaswLAqlUBcWnj30e4lVVy3jwSi
	 9NqICXdtPjWkiqP5FAFmqjjEv5L3eaNQk4wQE8Ci1uYkGBQ7UBt/Z3K9iHb64ULESB6vv
	 /yjbugytW2VFN1G99y9j+IZBvN7GsZ4qRKpgj0DqTk325QDHY60nrcUoISPIZRJfz24oh
	 4lxCXDSU056nmer+xM4DQOpTOggupTQmE0yTSswBu2KFS3HAOEkOPDD8BkvmsNwYuig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792642370;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RFvh/3Uw91jbtXCdw8cETloCk2Qba5GfK3RNi0MxwyY=;
	b=Jd9nvucJB2O8HTAUwu3lVbYUrcBFJaG8CJ4sn/OrXwjHiB6VP8bvNqCqw79VMUN4ptf3
	 RAwrXhpxQ4QtDOcXI7ARn4qlWvW/LC9ji2BEyCtO4E+qQkRb5ctRllhnqmW3rw2tYPdPk
	 IYGig/VJxMglASB4xJtcBeKs9SGQDxJgIdVWXNcog14qfHV6vqF0cBQPVUBho/txVlHXj
	 VRLgPcUKALkqkIYm2cGo8QLb3iQPsO6KrZ8cCHh6C+g//2m3Y0Od7Py13phdEn0c3RTc1
	 O9Q8vYAjX0ZsQGITfw1cvFWPu8vVXfOmSuxzZdYh5/+zutrrrUfOlkvodrud/kowEYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kp3I4RPG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NmtTTobP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C0606A31B
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 04:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C6C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kp3I4RPG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NmtTTobP
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M3jX7m2477341
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 04:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=RFvh/3Uw91jbtXCdw8cETloCk2Qba5GfK3RNi0MxwyY=; b=kp
	3I4RPGst1xBcpDpOejvDpwFc90UDpg/3VqfDe3C7cVxEJGZyCP9uP3FMgVMCJloy
	rcJJ9LyxLzNbey5T5ScvLurlEQvD6f9tYaGyEcxGoPkDLjoJMlQIDz/XtiDvKRIB
	djn9MFbd7owI6BYVETwxlQzyw6c+dzM67HcwIZFch/xPw2kWs0xFAd83hX6E2GE7
	yotQ9smROW6iN0tue04HmyDnMQaDNFJca/ANOeAVm8Rja3J8/9+A7rIZJNIn7fJT
	gbfwVY1wiKaT2UEA7FSIBNDxCWGulzxAeqt9DOs3LqaNt4di+uyTlpUMgpvKL6cg
	fgf+C1KINGYLMm7cXrMQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2kkgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 04:12:48 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66cbfb7ec42so2291296d50.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 21:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792642368; cv=none;
        d=google.com; s=arc-20260327;
        b=aZFs630uBz/EiPd79kVHdlk2KR7qc/LneTxIKtwC2CQMZaQ7UZ9B+H291Fa2L+W1C1
         aKRuaHRVN+9pfWqvVZMzPOfZx/y0QIQee7hTgFa1SnZwOD8EmHDW8NT7qnZhEViV0dt+
         qcwds/kfVroPyq+X/tA/KIKu+FRUyg/KUlnuejyo6BX7rK+WluEcoP7ocXYrN7Lz8//N
         fs52i3mfRjbz62nI2g7Ae4PO8ZTKJMvDBogFzK+L5g5avfH5NyNJ9ulwuKwftRVN5Sbd
         nkEuYtIbOJ1QcISA1Dy0vXoWxCVk/IdGUV5P9JGjzbcl5jceWWb+YefFejxPwo4cbzZz
         FhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=RFvh/3Uw91jbtXCdw8cETloCk2Qba5GfK3RNi0MxwyY=;
        fh=bdNpp0oYQUabLnCx1pYSacoHAxXf3GBBcC2KgvdlBio=;
        b=GXqSdi5X0DsHHzmuxVDU+YJ6UQOX6AFuuEMrYCmifrhQZMLkG+cbWYSM1+gvYPf20G
         Y5EYVTVtBPuyYlmd2n0ggc7H8Q3sz7PpFfBFZ54TKx3ys0j0YRdGetoO73lftWJKN+kN
         18CXdOjbl7Fp2WLtidFnelahTsZlb0+eHHYMIW0TmuNcADjb15fZbcJpGz36I8GQZCqa
         LhNkKTNi1auxCU1aUPHcT/MmiW6Rc3gBA1v/BsqRMk3y2KsXw8a/+0FY+/lQoDt526px
         YhzCISeTF57vC/b1XJ7tEB3gvW9Tshg9nPQDlCMu49iLHwyqOdF84q8ZI1kjyUu0hUYG
         7Heg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792642368; x=1793247168; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RFvh/3Uw91jbtXCdw8cETloCk2Qba5GfK3RNi0MxwyY=;
        b=NmtTTobPqFD3DpNq3SVHhQjY1HTzoJIP3kZpWXsLt2hC3seGUFN9iW1jbUPnD2uekM
         K2Tkl1Hfn2fv7dBPs+bjrnOIonTtD4QfNq3KstaciYE+AJwKologLPdGnnQLjnAVtrLa
         R7BrGgf5Sdamo4nrxCVhQ30KHkBgvIOGJzH2evPTa2lLVPaj33Jv7lBBbnhtJ084UeuU
         wQmf1dqk2v9u/8k33o09Q2H57aeFg2NPEMq9nl8gwUkRs4yDOHTGJ6NahZ7DSrdxKqiQ
         p/xmhQwkOon3zftoEuS7YuOWLTgAMsLxlGjSh1TcGTSU4XgXNqXNs1kNxUQ9mnk2B8Xy
         UR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792642368; x=1793247168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFvh/3Uw91jbtXCdw8cETloCk2Qba5GfK3RNi0MxwyY=;
        b=hYA8qN/mfk5FKfFMm9PQGCF7uRG62KMLOuk92Am7/Lp5ZA57o7hTCO+vkVMJsJLxNL
         Z44RS5EwBjbjXq/Ra7C36CfFXwJTmEv7ODe5Yq3l5dQN8xoO5CPQ1QED7Fs/JErVutJv
         ev7jzLcet8rZpvAxGOk3fmQowr379kjNIJnsao+QqPflsxoJWm+gRARyUrRFQr9X2uIl
         HHg6xvwZ7AZcWFrVzd6ZDuQTTqsCiHGulRgCAjj92T5I9B1irfX+Ua+KB6ihCzMlgmNO
         aJIjM46lk6L6jCWaLONZY1eujMxSthZTmA+c2SeeqXBDO+/o6j5FhC5Bp/e92gJJKGMR
         uoMg==
X-Forwarded-Encrypted: i=1; AKwUvBydgLgswEsXWg+2wThDdCtTlWG0YQYOfFZD9TSdMSbiV2x3kUdfrpEElnHVfVjDMnmscs1EUIEPDfQayAqi8A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKvy3cik/UqLkUI6DBqKunUOaE9BeWLK72WSyph8rJ+npCOco6M
	EaT+45XBbAvi7b9HP2eqeL81YpdebW1yAjzpERxA1ejlImUMxyS1G12EVpDEHQihIoM37oidNXQ
	LPtOO0DQCPsJF5RlOpSXNBRh/dPPmergVJ6+B2XA9SaPz4ByZ4qlCTZtZ9rrcruZCaosi8ipzA5
	5BycAZ+ydnUulBpZQkD5DxBeHCzXRIDB5mzM1nkg3fYFww
X-Gm-Gg: AYBFou0Y+OW9KZDQ224Fvk4jF5tJXq5P2yks+VwPweE9pliBEOFznaWiEiCS+uauqmZ
	QP1SbOcA2ibxjN7/kMAoIryxgLtYjuM+AbiUlAu7pAkBYzz6k8JXeLSdQtfpVmCVzeKWW5TpqyF
	2wIgd3uNrosfVWkCSqmyhMHuvo1SIgUCEvhMdex1ulexVaFeQMmmahJa8nLd8=
X-Received: by 2002:a05:690e:488d:10b0:679:a898:7d8b with SMTP id 956f58d0204a3-67a0e4bbf6emr1062076d50.35.1792642367590;
        Wed, 21 Oct 2026 21:12:47 -0700 (PDT)
X-Received: by 2002:a05:690e:488d:10b0:679:a898:7d8b with SMTP id
 956f58d0204a3-67a0e4bbf6emr1062061d50.35.1792642367081; Wed, 21 Oct 2026
 21:12:47 -0700 (PDT)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org>
 <20261003-dfustini-atl-sc-cbqri-dt-v9-2-52fd8be98dcf@kernel.org>
 <CAB19ukEkAOMnPpi2jVFz68GZ_7cwYmNtrBkxnfEJtFcPb7PJ5Q@mail.gmail.com> <atPhE6rF0Uz93qF2@thelio>
In-Reply-To: <atPhE6rF0Uz93qF2@thelio>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 09:42:35 +0530
X-Gm-Features: AclHuK_KjNarSdeGtOiebAPfz9T-Tt_QOkpNIpxbMPcQ9dxWkRZQBbqOt91xNeM
Message-ID: <CAB19ukGGcDgbewvdMf-TBCYSpN3ksvbU_tJSJdRx0-EKb4Ze_A@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: Drew Fustini <fustini@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>,
        Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>,
        Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>,
        Chen Pei <cp0613@linux.alibaba.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>,
        Gong Shuai <gong.shuai@sanechips.com.cn>,
        Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn,
        James Morse <james.morse@arm.com>,
        =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Peter Newman <peternewman@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>,
        Vasudevan Srinivasan <vasu@rivosinc.com>,
        Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
        yunhui cui <cuiyunhui@bytedance.com>,
        Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, devicetree@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAxNiBTYWx0ZWRfX6He3xHN1DtE0
 uC9Ti5wzJRQ31yOPEAwEZo6GXozlNE7UcWsR5/ho0iedxOuwpBP7HxA8+b4bHLpBSA1pzdjWQhK
 SoxVtWIrbzglUFvTHDqBnpWltenItkc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAxNiBTYWx0ZWRfXyMl6eT9E66hh
 NiYNJmL9ypclN+0DrVg7QcYV849HZITir/+jaMpaR3Z1zvBiJFTOa4tYEMIE2NdHOV9jm420d22
 KnUxKHpl5Bfj4AeO0f9W6TriD03qLZMZe9vD9OEgLALfDQS1wcvW56B9e6K+G+qfwaBGTLMgbNl
 lFrlnQX7KMamjrIWOCO2t99Dj4Fk9aP6NAUPA6Z1kcevEoDFikNKwbwWnnGz5i1VPevMI1UR46T
 k7YD/xf8/zW9NQXyzG0qWUvTeQS/nwsUHYHlfjC51F+uzMSUV6Qxn291czC1ieBK1u5beboeO8U
 d6c+wie7SGzBj7dSQR8XVpIeovbukuDsU7vMoXix68uvwoGbC+ecfyjYJCYF4zqoiXqlyGZpURz
 9nILIFrNtIiQOYjeHGgksn9orPmJ6mXzOpUMyG4veJEJTHV1K59qhIhyFTgbH8jsO094G6zJf59
 gfzqFgtbEaSwfoMNg9A==
X-Proofpoint-ORIG-GUID: 2yht9zwnMasGoN0Qf9RO31uw02bjANC7
X-Proofpoint-GUID: 2yht9zwnMasGoN0Qf9RO31uw02bjANC7
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad98d40 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=IpJZQVW2AAAA:8
 a=jDNYHvWEAysQCaIWslsA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220016

On Sun, Oct 18, 2026 at 2:26=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> On Mon, Oct 12, 2026 at 10:23:57PM +0530, Sunil V L wrote:
> > On Sat, Oct 3, 2026 at 12:45=E2=80=AFPM Drew Fustini <fustini@kernel.or=
g> wrote:
> > >
> > > Wire CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2 and
> > > RDT_RESOURCE_L3 schemata.
> > >
> > > resctrl exposes a single capacity mask per resource, so when more tha=
n
> > > one capacity controller backs a cache level they must report the same
> > > number of capacity blocks. The same holds for the other capabilities
> > > resctrl exposes once per resource. A level whose controllers disagree
> > > is left unexposed. Other levels are unaffected.
> > >
> > > The set of controllers backing each level is fixed when resctrl is se=
t
> > > up at late_initcall. Control domains are created in the cpuhp online
> > > callback and keyed on the onlining CPU's cache id from cacheinfo, so =
a
> > > CPU that is offline at probe time still joins its domain once it come=
s
> > > online, provided a controller for its cache is in that set. A CPU who=
se
> > > cache has no controller is left out of that level and a warning is
> > > logged once. A domain is published on the ctrl_domains RCU list only
> > > after it is fully initialized and brought online, and removed from th=
e
> > > list before it is taken offline, following the documented safe
> > > traversal rules.
> > >
> > > Assisted-by: LLM
> > > Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> > > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > > ---
> > >  MAINTAINERS                      |   2 +
> > >  arch/riscv/include/asm/resctrl.h | 147 +++++++
> > >  drivers/resctrl/Kconfig          |   4 +
> > >  drivers/resctrl/Makefile         |   1 +
> > >  drivers/resctrl/cbqri_resctrl.c  | 831 +++++++++++++++++++++++++++++=
++++++++++
> > >  5 files changed, 985 insertions(+)
> [..]
> > > diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_=
resctrl.c
> > > new file mode 100644
> > > index 000000000000..f10a24761b25
> > > --- /dev/null
> > > +++ b/drivers/resctrl/cbqri_resctrl.c
> [..]
> > > +static int cbqri_resctrl_setup(void)
> > > +{
> > > +       int rid;
> > > +       int err;
> > > +
> > > +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++)
> > > +               cbqri_resctrl_resources[rid].resctrl_res.rid =3D rid;
> > > +
> > Why can't cbqri_resctrl_control_init directly use
> > cbqri_resctrl_resources? I feel this initialization is redundant.
>
> This is similar to what x86 and arm mpam also do since it is important
> before any resctrl code is called. for_each_rdt_resource() will get
> stuck in a loop if the rid values are not initialized. In contrast,
> cbqri_resctrl_control_init() only handles the resources for which
> cbqri_resctrl_pick_caches() found a controller.
>
> The initialization could be moved into cbqri_resctrl_control_init()
> before any early return paths but it does introduce the possibility that
> rid initialization could be missed if cbqri_resctrl_control_init() is
> ever refactored. Given that, I'm inclined to keep the current structure.
>
Sure. Thanks for the explanation.

Thanks,
Sunil
