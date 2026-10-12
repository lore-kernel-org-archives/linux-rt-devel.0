Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B94A3F1D
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821596; cv=pass; b=lm1rdpQL3gU+cA62XJmxhtZ6f+H0/JUUa9k8TmWHvrKBwZSpHn2s3MST0LOe4o5wUtgAYKHq9+peuYrOdhcuE8eQR9BVAfWv5e0pRPtoigYK8jadkDRNrlb1AY8jB3SpuaU8Z/4EDzqVU+MFGQxwSzI/ApVQ4UVawFCA/5Yg3F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821596; c=relaxed/simple;
	bh=TTjf5V4wCD8UDLoFYWTPTuwqAVR0bEmlXILLq+Upov4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEkLgapUXXObUWJvAhqYuHtDgpEEICiF/UTkSvZ2nbuunbnThvQHi2CnLIIuDuu21SW82AqxD1ztOWYBn0UBevsX8jD8ViDe6YSnBjCj5GEXtUFf2Y31rgB5epGdZ6Z3ZJOSAed90pb9Pst9tjO+4SiZqVYxog04dEiTGtdkEz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gcEayE9l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XirpX2QN; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcEayE9l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XirpX2QN"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFerCP3272302
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=tpTbddoXq5YWx0hV9l3rrOWYqp3vBN87H88RRUZEdxM=; b=gc
	EayE9lLx2Q1OQmdAU1KvLv/MHKQ5uASTeR/IHI0WPTA21YiIESFRuXf6eoBZwtYp
	i60++V/rhlnA57qnF7novfre3ubvUch4VkzHrZGHqq1Q9UsI5xYda71p1b1zjoK9
	SNZYP309mtj55IBl33MJHqAdde4BC0BggN6nmXfeMmIGN9Ne5L8Mu49ens/4dETt
	3nYSr7hDpWejHeEuXkckstCVY+RPQRFwyelQ/zDK7QypmrGrSMQHNHSuLq3M6/Bc
	1e3JdqgMe5PrWj/zBvlW+8Vt4gFiGmzsRZijRMmpIGzrhA+SEcU3p6dBEVCfxWQ4
	g4HSXtKUMIsl7bOupa+g==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffhkbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:13:12 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-677ba0a4ea2so2595990d50.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 09:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791821592; cv=none;
        d=google.com; s=arc-20260327;
        b=l2CEAKiEV3XX307ZoadtqRaV3YjAir/LFmZShbJ+ZXkxGpfWt6tt7Axha+/H1VPu5X
         RgrPky1oAqCi9W6U1nAMv9viGrnrRAzaY/crJWCn8Sg39kQ2ZAuRcnQd0S3Vckn4y9ht
         JHDLXF4KbdJCwzJTXvBDvSq6FsmUhMI1ga2CVtPVmOG5/dQl9ZOq6zcx0M7H5GP5fYzI
         9MLvWmOxvTY340ex0sgPddFSjwBNcvrYI2UqcE2/2t1InKLRwffZBxq3/nfOdjCYW3m0
         9fXkTdFRlr/SKSRHPGWx6RaIV4o1ffBnP9oLxVpVY/RpzHoOIDZpktJiSOvyPJOQyiCi
         HSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=tpTbddoXq5YWx0hV9l3rrOWYqp3vBN87H88RRUZEdxM=;
        fh=ToDkKe4QbkLDhzIuyl9UyNnUpMJ1zEF4P2Kt92rNcyc=;
        b=HZAoWr5/xucnd5995g7oSdoBGSnp8ayQYJPm2G4Xqvyki5bLkNG3HrU6uploW/VBIm
         njhsr0Dn/tULYJEfA2JfyJhxcn7lt592ybnGlI5guJzf2s56YziDZKs7+h45XvGTDo2e
         mjkNBT9ox2xfa0lvjpo3r7ucRpw6LSg4n0KfnkdFQhvClpi8XC+DH1WjFsEJxSpuMPjT
         PHRvVv6KZwe5J9O7AhzDVIkF/BhWlro2CYsEbAdIgNrunEkXUl2s33gqCnUSEA+vUG/i
         o0FfmR6ZG8zoisPmtCWlRJP9wQ6Rhmk5Uo9rWyIjYHfn2NBWoM/b6xqpsxr+rOtTRH+i
         kgRg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791821592; x=1792426392; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tpTbddoXq5YWx0hV9l3rrOWYqp3vBN87H88RRUZEdxM=;
        b=XirpX2QNyJlR+uzmPKwbyjW++glMh6YYkgu4Mg9lyi5s8kg8qpyb0zJjpBXK5Bj5+k
         qeh/J8rNi12BW5VWtF5MkkThDvrVnycJSKM8sWT5XKc4+HUL0ktkv2MFpufeFpR+8NXd
         dEwRYu24/E5IS+S4pu/G+xLrGTvpIduPsrHbKJwJ4lPGzR81soJIZAStgGsOvqqeug5M
         HIBnroA/ujD+oLX6guYI4PA0Ws79f4cShV9WvZBVYdvAmiwpBVVTTZb74PdNKA0EX1ra
         hfCAVgnxIoi0EArjhIWDwpz5Y7z5FXbqiH0/AmVoUKH4SRf9u94tSoaoSzI/ofglBcfp
         sgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791821592; x=1792426392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tpTbddoXq5YWx0hV9l3rrOWYqp3vBN87H88RRUZEdxM=;
        b=zjf945lnOpqJdTVWWWK8gcmWLFHHklAlEUpFdfPybkkEwyCc5Wx3TDh/3xV04vOnop
         rfCPURW168xD+clxtDy0J2AM2sn4S1rmlS1jJuAdJPVgYDIGICjwWBiJwQRBc1HHIK6P
         Fnk2xvj38gpf17zZk7f4ZbBu8jsU2ij4panCx9gDu42wrVjIsFbuukruWKRBVvWpM3VQ
         7SperX/C0vpykGcJ4CrGq385Tj0YA86cSsJ1SoadDvH31yQlnn8tpjC0p85ovF5JkXOz
         LYFsqkA8XOXQfk95MRCmN65QIBjX0vDmtdhrIjUc1SrnBxc3M/8kPxQ00UixHUdCliK8
         cqvw==
X-Forwarded-Encrypted: i=1; AKwUvBwDOCxesbuzr4nhKLOjLUJbNSkJZJZqQZVQeGf1JVGLGZZ5ligCETyc5i5GNM5NjVKQddPi5+DehA+1ZOGIeA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJx9DFsDSMxlLbsod6+RLKrw3hgtzBFp0aL0BhppQnIBfzlT70d
	oGjakhJfKTtW0uuHNuPXrzpl+YYflCIs34DZ+mDgg1Wpthb2IDSEQB2TaCjgCNKFprtRqwTJgzb
	1+sAXZEqguF57ajWQrCCuv0sfg5+0qCvc3AzreFlGknNehgmnVm55rXNTSNvw1jjgssWuAQn+rA
	gEIaepqAZwI+aZksydSnauJNH2jyCNaPo/zqG3J9FIRDVP
X-Gm-Gg: AYBFou0tPk+6DnXxMM42ATBO2aJjDB5Q+hXC8B5QAsZz3MQ+2x1cqkTDTXDuyNn3gvk
	jpUTC1/ST83II92Qvx8tVEJ9CgPwlZe8+fFZI+f/VGgEdFWmFu+3NvgrnLh1phFZG3ka0yRE/6/
	g9iKLWmHVeFbhZZft4uxzmzF0qZT81XRzW3Vy31uotRaLaHIAFwwavhU4qE8U=
X-Received: by 2002:a05:690e:4146:b0:677:a004:4c38 with SMTP id 956f58d0204a3-679369ec4f1mr3308747d50.44.1791821591456;
        Mon, 12 Oct 2026 09:13:11 -0700 (PDT)
X-Received: by 2002:a05:690e:4146:b0:677:a004:4c38 with SMTP id
 956f58d0204a3-679369ec4f1mr3308739d50.44.1791821590743; Mon, 12 Oct 2026
 09:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org> <20261003-dfustini-atl-sc-cbqri-dt-v9-1-52fd8be98dcf@kernel.org>
In-Reply-To: <20261003-dfustini-atl-sc-cbqri-dt-v9-1-52fd8be98dcf@kernel.org>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 21:42:59 +0530
X-Gm-Features: AclHuK-vYlJYM0E67nMSQqUdwxkYWon0umB4kiTcvSGU6Gl_S9cUjco2r0wx7Wc
Message-ID: <CAB19ukHJ-TxXu+vMGGNqHz2sJj35Cg0X1RbcdfXzwDYpci1jQw@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] riscv_cbqri: Add capacity controller probe and
 allocation device ops
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NCBTYWx0ZWRfXxiFMvdi6VgKe
 tq+XGx72wJmwkJvBiJdISPd1RWXozdvqjOriTVbndHdab+1bjpwuQUOTbeksyPtEq5o1hFTa8QC
 yBTOPg+7r1D7MdCu1VP37BPIidFQgywE/win5CXMNM5O74+P9RkPK7Wq4HjAvu/2Ukmxh91bd+v
 eZ4jmr7g3J1dwxv0/MO8QM82/JCIIJjpPs9YLpGyCB6XltnDPjIEObXRAWwBkS4z1v3qdmybrTv
 JhBYv/Ls53JFaOy/vRo/IEvgWERkZ6085A2BKRJP23GGhNn8c86DCDgSFzV0RoT+dqRE4VqY2MT
 6vqHNHTNYVDYANWNiGpI2LBEAGrmJ01tRGoAp2suKe3YypY5lJw4mWgd5Xf4ggFdDjaxR2rSAze
 Q3Qduz1wopHlL9A9FCnxKrf+JgrU+tqcl7azoYFclyFTjV9JA2S2OfboUkgTSn0SnlPQwue1jVg
 dD/Or5K2R+KaR0Rg88A==
X-Proofpoint-GUID: zCAuigYbU-PGeeu9R4zG6hMtLMqG_2Do
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NCBTYWx0ZWRfXx1V1nbOx1LvI
 pJpfJQk11WiTOnldrZX7Ia2pihQjW8LcvCVfEQ8CaKaEMs1jxlcx5OVpNJgpyYFhUnIEJIxSqAr
 jhFFLMYUo1rqLLElyMrlWGxcAtbTsMo=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acd0718 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=JfrnYn6hAAAA:8
 a=phdsoJfCAAAA:8 a=8jkcZq7Tha-1975ww3UA:9 a=2s2eUrNZQbw0ccrE:21
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=vJu9hbFHM92-Vd_OvO9C:22
X-Proofpoint-ORIG-GUID: zCAuigYbU-PGeeu9R4zG6hMtLMqG_2Do
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120064

Hi Drew!

On Sat, Oct 3, 2026 at 12:45=E2=80=AFPM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add support for the RISC-V CBQRI capacity controller. A platform driver
> passes a cbqri_controller_info descriptor together with the cache level
> to riscv_cbqri_register_cc_dt(), which probes the controller and adds it
> to the controller list.
>
> Assisted-by: LLM
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                      |   3 +
>  drivers/resctrl/Kconfig          |   9 +
>  drivers/resctrl/Makefile         |   3 +
>  drivers/resctrl/cbqri_devices.c  | 574 +++++++++++++++++++++++++++++++++=
++++++
>  drivers/resctrl/cbqri_internal.h | 122 +++++++++
>  include/linux/riscv_cbqri.h      |  45 +++
>  6 files changed, 756 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c..92b111cd25c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23571,6 +23571,9 @@ L:      linux-riscv@lists.infradead.org
>  S:     Supported
>  F:     arch/riscv/include/asm/qos.h
>  F:     arch/riscv/kernel/qos.c
> +F:     drivers/resctrl/cbqri_devices.c
> +F:     drivers/resctrl/cbqri_internal.h
> +F:     include/linux/riscv_cbqri.h
>
>  RISC-V RPMI AND MPXY DRIVERS
>  M:     Rahul Pathak <rahul@summations.net>
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index 672abea3b03c..1219fb29aa2e 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -29,3 +29,12 @@ config ARM64_MPAM_RESCTRL_FS
>         default y if ARM64_MPAM_DRIVER && RESCTRL_FS
>         select RESCTRL_RMID_DEPENDS_ON_CLOSID
>         select RESCTRL_ASSIGN_FIXED
> +
> +menuconfig RISCV_CBQRI
> +       bool "RISC-V CBQRI support"
> +       depends on RISCV && RISCV_ISA_SSQOSID
> +       help
> +         Capacity and Bandwidth QoS Register Interface (CBQRI) support f=
or
> +         RISC-V cache QoS resources. CBQRI exposes cache capacity
> +         allocation through the resctrl filesystem at /sys/fs/resctrl wh=
en
> +         RESCTRL_FS is also enabled.
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4f6d0e81f9b8..4d8a2c4b5627 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -3,3 +3,6 @@ mpam-y                                          +=3D mpam=
_devices.o
>  mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)           +=3D mpam_resctrl.o
>
>  ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)      +=3D -DDEBUG
> +
> +obj-$(CONFIG_RISCV_CBQRI)                      +=3D cbqri.o
> +cbqri-y                                                +=3D cbqri_device=
s.o
> diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devi=
ces.c
> new file mode 100644
> index 000000000000..87d4ecf8f141
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_devices.c
> @@ -0,0 +1,574 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/riscv_cbqri.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <asm/csr.h>
> +
> +#include "cbqri_internal.h"
> +
> +LIST_HEAD(cbqri_controllers);
> +
> +/*
> + * Serializes cbqri_controllers mutations against a concurrent insert un=
der
> + * asynchronous driver probing, and against the boot-time walk in the re=
sctrl
> + * glue. The glue keeps its own copy of the controllers it picked, so it=
s
> + * cpuhp paths never walk this list.
> + */
> +DEFINE_MUTEX(cbqri_controllers_lock);
> +
> +/*
> + * CBQRI registers are 64-bit, but the spec only guarantees single-copy
> + * atomicity for naturally aligned 4-byte accesses. Read the two halves =
and
> + * reconstruct, so the driver does not rely on native 64-bit MMIO.
> + *
> + * The halves are not sampled atomically, but a tear is harmless. The fi=
elds
> + * that change while an operation runs, BUSY (bit 39) and STATUS (bits
> + * 38:32), are in the high half and read by the single high readl(). The=
 low
> + * half (OP/AT/RCID) is software-written and constant for the operation.
> + */
> +static u64 cbqri_readq(void __iomem *addr)
> +{
> +       u32 lo =3D readl(addr);
> +       u32 hi =3D readl(addr + 4);
> +
> +       return (u64)hi << 32 | lo;
> +}
> +
> +/* Set capacity block mask (cc_block_mask) */
> +static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
> +{
> +       /*
> +        * cbqri_probe_cc() rejects ncblks > 32, so the mask fits the low=
 word.
> +        * Per CBQRI 3.5 the cc_block_mask bits above NCBLKS are read-onl=
y zero,
> +        * so the upper word needs no write.
> +        */
> +       writel(lower_32_bits(cbm), ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +}
> +
> +/*
> + * Clear cc_cunits so a CONFIG_LIMIT on a CUNITS-capable controller impo=
ses no
> + * capacity-unit limit. resctrl models only the block mask. On controlle=
rs
> + * with cc_capabilities.CUNITS =3D=3D 0 the register is read-only zero, =
so there is
> + * nothing to do.
> + */
> +static void cbqri_clear_cunits(struct cbqri_controller *ctrl)
> +{
> +       if (ctrl->cc.cunits) {
> +               writel(0, ctrl->base + CBQRI_CC_CUNITS_OFF);
> +               writel(0, ctrl->base + CBQRI_CC_CUNITS_OFF + 4);
> +       }
> +}
> +
> +static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_o=
ffset,
> +                               u64 *regp)
> +{
> +       u64 reg;
> +       int ret;
> +
> +       /*
> +        * Sleeping poll: caller holds ctrl->lock as a sleeping mutex, so
> +        * 10us/1ms is safe under PREEMPT_RT.
> +        */
> +       ret =3D read_poll_timeout(cbqri_readq, reg,
> +                               !FIELD_GET(CBQRI_CONTROL_REGISTERS_BUSY_M=
ASK, reg),
> +                               10, 1000, false, ctrl->base + reg_offset)=
;
> +       if (ret)
> +               return ret;
> +       if (regp)
> +               *regp =3D reg;
> +       return 0;
> +}
> +
> +/*
> + * Perform capacity allocation control operation on capacity controller.
> + * cbm is staged in cc_block_mask and cc_cunits is cleared only after BU=
SY
> + * reads 0, since CBQRI 3.4 leaves writes to those registers UNSPECIFIED
> + * while an operation is in flight. READ_LIMIT overwrites both on succes=
s,
> + * so staging 0 before a read makes a silent firmware no-op visible.
> + * Caller must hold ctrl->lock.
> + */
> +static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operatio=
n,
> +                            int rcid, u32 at, u64 cbm)
> +{
> +       int reg_offset =3D CBQRI_CC_ALLOC_CTL_OFF;
> +       int status;
> +       u64 reg;
> +
> +       lockdep_assert_held(&ctrl->lock);
> +
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err_ratelimited("BUSY timeout before starting operatio=
n\n");
> +               return -EIO;
> +       }
> +
> +       cbqri_set_cbm(ctrl, cbm);
> +       cbqri_clear_cunits(ctrl);
> +
> +       FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_OP_MASK, &reg, operation);
> +       FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_RCID_MASK, &reg, rcid);
> +
> +       /*
> +        * CBQRI Table 1: AT 0=3DData, 1=3DCode. Program AT on controller=
s
> +        * that report supports_alloc_at_code. On controllers that don't,
> +        * AT is reserved-zero and the op acts on both halves.
> +        */
> +       reg &=3D ~CBQRI_CONTROL_REGISTERS_AT_MASK;
> +       if (ctrl->cc.supports_alloc_at_code)
> +               reg |=3D FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK, at);
> +
> +       writel(lower_32_bits(reg), ctrl->base + reg_offset);
> +
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err_ratelimited("BUSY timeout during operation\n");
> +               return -EIO;
> +       }
> +
> +       status =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
> +       if (status !=3D CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS) {
> +               pr_err_ratelimited("operation %d failed: status=3D%d\n", =
operation, status);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Apply a capacity block mask and verify via CONFIG_LIMIT + READ_LIMIT.
> + *
> + * AT-capable controllers with CDP off need a second CONFIG_LIMIT on the
> + * other AT half (the spec encodes AT only as 0=3DData / 1=3DCode, there=
 is
> + * no "both halves" value). CDP-on issues separate per-type writes from
> + * resctrl, so a single CONFIG_LIMIT per call is correct.
> + */
> +int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
> +                            const struct cbqri_cc_config *cfg)
> +{
> +       bool need_at_mirror;
> +       u64 saved_cbm =3D 0;
> +       int err =3D 0;
> +       u64 reg;
> +
> +       mutex_lock(&ctrl->lock);
> +
> +       need_at_mirror =3D ctrl->cc.supports_alloc_at_code && !cfg->cdp_e=
nabled;
> +
> +       /*
> +        * Capture the cfg->at half CBM before any write so a partial
> +        * AT-mirror failure can revert and keep the two halves consisten=
t.
> +        */
> +       if (need_at_mirror) {
> +               err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_REA=
D_LIMIT,
> +                                       closid, cfg->at, 0);
> +               if (err < 0)
> +                       goto out;
> +               saved_cbm =3D cbqri_readq(ctrl->base + CBQRI_CC_BLOCK_MAS=
K_OFF);
> +       }
> +
> +       /* Capacity config limit operation for the AT half implied by cfg=
->at */
> +       err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMI=
T,
> +                               closid, cfg->at, cfg->cbm);
> +       if (err < 0)
> +               goto out;
> +
> +       /*
> +        * CDP-off mirror: on AT-capable controllers, also program the
> +        * other AT half with the same mask so the two halves stay in syn=
c.
> +        */
> +       if (need_at_mirror) {
> +               u32 other =3D (cfg->at =3D=3D CBQRI_CONTROL_REGISTERS_AT_=
CODE) ?
> +                           CBQRI_CONTROL_REGISTERS_AT_DATA :
> +                           CBQRI_CONTROL_REGISTERS_AT_CODE;
> +
> +               err =3D cbqri_cc_alloc_op(ctrl,
> +                                       CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMI=
T,
> +                                       closid, other, cfg->cbm);
> +               if (err < 0) {
> +                       int rerr;
> +
> +                       /*
> +                        * Best-effort revert of the cfg->at half so the =
two
> +                        * halves stay in sync. A schemata read sees only=
 one
> +                        * half, so silent divergence would otherwise rep=
ort
> +                        * the new value as if the write had succeeded.
> +                        */
> +                       rerr =3D cbqri_cc_alloc_op(ctrl,
> +                                                CBQRI_CC_ALLOC_CTL_OP_CO=
NFIG_LIMIT,
> +                                                closid, cfg->at, saved_c=
bm);
> +                       if (rerr < 0)
> +                               pr_err_ratelimited("AT-mirror revert fail=
ed (err=3D%d), AT halves diverged\n",
> +                                                  rerr);
> +                       goto out;
> +               }
> +       }
> +
> +       /* Read the limit back to verify the block mask landed */
> +       err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
> +                               closid, cfg->at, 0);
> +       if (err < 0)
> +               goto out;
> +
> +       /*
> +        * Read capacity blockmask and narrow to u32 to match resctrl's C=
BM
> +        * width. cbqri_probe_cc() rejects ncblks > 32 so the upper bits =
are
> +        * reserved zero.
> +        */
> +       reg =3D cbqri_readq(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +       if (lower_32_bits(reg) !=3D cfg->cbm) {
> +               pr_err_ratelimited("CBM verify mismatch (reg=3D%llx !=3D =
cbm=3D%llx)\n",
> +                                  reg, cfg->cbm);
> +               err =3D -EIO;
> +       }
> +
> +out:
> +       mutex_unlock(&ctrl->lock);
> +       return err;
> +}
> +
> +/* Read the configured CBM for closid on the at half via READ_LIMIT. */
> +int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
> +                           u32 at, u32 *cbm_out)
> +{
> +       int err;
> +
> +       mutex_lock(&ctrl->lock);
> +       err =3D cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,=
 closid, at, 0);
> +       if (err =3D=3D 0) {
> +               /*
> +                * resctrl exposes the CBM as a u32 and cbqri_probe_cc() =
rejects
> +                * ncblks > 32, so the mask fits the low 32-bit word of t=
he
> +                * cc_block_mask register.
> +                */
> +               *cbm_out =3D readl(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
> +       }
> +       mutex_unlock(&ctrl->lock);
> +       return err;
> +}
> +
> +static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_of=
fset,
> +                              int operation, int *status, bool *access_t=
ype_supported)
> +{
> +       const u64 active_mask =3D CBQRI_CONTROL_REGISTERS_OP_MASK |
> +                               CBQRI_CONTROL_REGISTERS_AT_MASK |
> +                               CBQRI_CONTROL_REGISTERS_RCID_MASK;
> +       u64 reg, saved_reg;
> +       int at;
> +
> +       /*
> +        * Default the output to false so the status=3D=3D0 (feature not
> +        * implemented) path returns a deterministic value to the caller
> +        * rather than leaving an uninitialized bool.
> +        */
> +       *access_type_supported =3D false;
> +
> +       /* Keep the initial register value to preserve the WPRI fields */
> +       reg =3D cbqri_readq(ctrl->base + reg_offset);
> +       saved_reg =3D reg;
> +
> +       /* Drain any in-flight firmware op before issuing our own write. =
*/
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &saved_reg) < 0) {
> +               pr_err("BUSY timeout before probe operation\n");
> +               return -EIO;
> +       }
> +
> +       /*
> +        * Execute the requested operation with all active fields
> +        * (OP/AT/RCID) zeroed except OP itself. Every bit not in
> +        * active_mask is WPRI and gets carried over from saved_reg.
> +        */
> +       reg =3D (saved_reg & ~active_mask) |
> +             FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
> +       writel(lower_32_bits(reg), ctrl->base + reg_offset);
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +               pr_err_ratelimited("BUSY timeout during operation\n");
> +               return -EIO;
> +       }
> +
> +       /* Get the operation status */
> +       *status =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
> +
> +       /*
> +        * Check for the AT support if the register is implemented
> +        * (if not, the status value will remain 0)
> +        */
> +       if (*status !=3D 0) {
> +               /*
> +                * Re-issue operation with AT=3DCODE so the controller
> +                * latches AT=3DCODE on supported hardware (or resets it =
to 0
> +                * on hardware that doesn't). OP must be a defined CBQRI =
op
> +                * here. OP=3D0 is a no-op and would silently disable CDP=
.
> +                */
> +               reg =3D (saved_reg & ~active_mask) |
> +                     FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operati=
on) |
> +                     FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
> +                                CBQRI_CONTROL_REGISTERS_AT_CODE);
> +               writel(lower_32_bits(reg), ctrl->base + reg_offset);
> +               if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
> +                       pr_err("BUSY timeout setting AT field\n");
> +                       return -EIO;
> +               }
> +
> +               /*
> +                * If the AT field value has been reset to zero,
> +                * then the AT support is not present
> +                */
> +               at =3D FIELD_GET(CBQRI_CONTROL_REGISTERS_AT_MASK, reg);
> +               if (at =3D=3D CBQRI_CONTROL_REGISTERS_AT_CODE)
> +                       *access_type_supported =3D true;
> +       }
> +
> +       /*
> +        * Restore the original register value.
> +        * Clear OP to avoid re-triggering the probe op.
> +        */
> +       saved_reg &=3D ~CBQRI_CONTROL_REGISTERS_OP_MASK;
> +       writel(lower_32_bits(saved_reg), ctrl->base + reg_offset);
> +       if (cbqri_wait_busy_flag(ctrl, reg_offset, NULL) < 0) {
> +               pr_err("BUSY timeout restoring register value\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cbqri_probe_cc(struct cbqri_controller *ctrl)
> +{
> +       int err, status;
> +       int ver_major, ver_minor;
> +       u64 reg;
> +
> +       reg =3D cbqri_readq(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
> +       if (reg =3D=3D 0) {
> +               pr_warn("CC at %pa: cc_capabilities reads 0, skipping\n",
> +                       &ctrl->addr);
> +               return -ENODEV;
> +       }
> +
> +       ver_minor =3D FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MINOR_MASK, reg=
);
> +       ver_major =3D FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK, reg=
);
> +       ctrl->cc.ncblks =3D FIELD_GET(CBQRI_CC_CAPABILITIES_NCBLKS_MASK, =
reg);
> +
> +       pr_debug("version=3D%d.%d ncblks=3D%d cache_level=3D%d\n",
> +                ver_major, ver_minor,
> +                ctrl->cc.ncblks, ctrl->cache.cache_level);
> +
> +       /*
> +        * NCBLKS =3D=3D 0 would divide-by-zero in the schemata math whil=
e
> +        * ctrl->lock is held.
> +        */
> +       if (!ctrl->cc.ncblks) {
> +               pr_warn("CC at %pa has 0 capacity blocks, skipping\n",
> +                       &ctrl->addr);
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * resctrl represents the capacity bitmask (CBM) as a u32, so a
> +        * controller with more than 32 capacity blocks cannot be express=
ed
> +        * through the schemata interface. Skip it rather than truncate.
> +        */
> +       if (ctrl->cc.ncblks > 32) {
> +               pr_warn("CC at %pa has ncblks=3D%u > 32 (resctrl CBM is u=
32), skipping\n",
> +                       &ctrl->addr, ctrl->cc.ncblks);
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * On a CUNITS-capable controller, CONFIG_LIMIT also consumes cc_=
cunits,
> +        * whose reset value is unspecified. The driver clears it to 0 (n=
o limit)
> +        * on every CONFIG_LIMIT, so cc_cunits at 0x28 must be within the=
 mapping.
> +        */
> +       ctrl->cc.cunits =3D FIELD_GET(CBQRI_CC_CAPABILITIES_CUNITS_MASK, =
reg);
> +       if (ctrl->cc.cunits && ctrl->size < CBQRI_CC_CUNITS_OFF + 8) {
> +               pr_warn("CC at %pa supports CUNITS but maps only %pa, ski=
pping\n",
> +                       &ctrl->addr, &ctrl->size);
> +               return -ENODEV;
> +       }
> +
> +       /* Probe allocation features */
> +       err =3D cbqri_probe_feature(ctrl, CBQRI_CC_ALLOC_CTL_OFF,
> +                                 CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
> +                                 &status, &ctrl->cc.supports_alloc_at_co=
de);
> +       if (err)
> +               return err;
> +
> +       if (status =3D=3D CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS)
> +               ctrl->alloc_capable =3D true;
> +
> +       return 0;
> +}
> +
> +static int cbqri_probe_controller(struct cbqri_controller *ctrl)
> +{
> +       int err;
> +
> +       pr_debug("controller info: type=3D%d addr=3D%pa size=3D%pa max-rc=
id=3D%u\n",
> +                ctrl->type, &ctrl->addr, &ctrl->size, ctrl->rcid_count);
> +
> +       if (!ctrl->addr) {
> +               pr_warn("controller has invalid addr=3D0x0, skipping\n");
> +               return -EINVAL;
> +       }
> +
> +       if (ctrl->size < CBQRI_CTRL_MIN_REG_SPAN) {
> +               pr_warn("controller at %pa: size %pa < minimum 0x%x, skip=
ping\n",
> +                       &ctrl->addr, &ctrl->size, CBQRI_CTRL_MIN_REG_SPAN=
);
> +               return -EINVAL;
> +       }
> +
> +       if (!request_mem_region(ctrl->addr, ctrl->size, "cbqri_controller=
")) {
> +               pr_err("request_mem_region failed for %pa\n", &ctrl->addr=
);
> +               return -EBUSY;
> +       }
> +
Apologies for jumping on this late. But why not simply use
devm_platform_ioremap_resource() ?

> +       ctrl->base =3D ioremap(ctrl->addr, ctrl->size);
> +       if (!ctrl->base) {
> +               pr_err("ioremap failed for %pa\n", &ctrl->addr);
> +               err =3D -ENOMEM;
> +               goto err_release;
> +       }
> +
> +       switch (ctrl->type) {
> +       case CBQRI_CONTROLLER_TYPE_CAPACITY:
> +               err =3D cbqri_probe_cc(ctrl);
> +               break;
> +       default:
> +               pr_err("unknown controller type %d\n", ctrl->type);
> +               err =3D -ENODEV;
> +               break;
> +       }
> +
> +       if (err)
> +               goto err_iounmap;
> +
> +       return 0;
> +
> +err_iounmap:
> +       iounmap(ctrl->base);
> +       ctrl->base =3D NULL;
> +err_release:
> +       release_mem_region(ctrl->addr, ctrl->size);
> +       return err;
> +}
> +
> +void cbqri_controller_destroy(struct cbqri_controller *ctrl)
> +{
> +       /*
> +        * cbqri_probe_controller() clears ctrl->base on its error paths =
and
> +        * releases the mem region itself, so reach into both only when
> +        * destroy is rolling back a successful probe.
> +        */
> +       if (ctrl->base) {
> +               iounmap(ctrl->base);
> +               release_mem_region(ctrl->addr, ctrl->size);
> +       }
> +       kfree(ctrl);
> +}
> +
> +/**
> + * riscv_cbqri_register_cc_dt() - register a DT-described capacity contr=
oller
> + * @info:        registration descriptor. info->cache_id is used as the
> + *               resctrl domain id. info->type must be CAPACITY.
> + * @cache_level: cache level (2 or 3) the controller backs, mapped to th=
e
> + *               resctrl L2/L3 resource by the resctrl glue.
> + *
> + * The cache level and id (info->cache_id) are supplied directly by the
> + * caller, which resolves them from cacheinfo. Domain membership is reso=
lved
> + * per CPU at hotplug, so no cpu mask is stored. There is no firmware ta=
ble
> + * to resolve any of this from.
> + *
> + * Return: 0 on success, -EEXIST when a controller for the same cache le=
vel
> + * and id is already registered, or another negative errno on failure.
> + */
> +int riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
> +                              u32 cache_level)
>
What is DT specific code in this function? IMO, it is better to gather
all information in the main
driver itself into a generic "info" structure. That way, all ACPI vs
DT differences will be handled in
one place and everything further will be generic.

> +{
> +       struct cbqri_controller *ctrl, *other;
> +       int err;
> +
> +       if (!info->addr) {
> +               pr_warn("skipping controller with invalid addr=3D0x0\n");
> +               return -EINVAL;
> +       }
> +
> +       if (info->type !=3D CBQRI_CONTROLLER_TYPE_CAPACITY) {
> +               pr_warn("register_cc_dt called with non-capacity type %u\=
n",
> +                       info->type);
> +               return -EINVAL;
> +       }
> +
> +       ctrl =3D kzalloc(sizeof(*ctrl), GFP_KERNEL);
> +       if (!ctrl)
> +               return -ENOMEM;
> +
> +       mutex_init(&ctrl->lock);
> +
> +       ctrl->addr =3D info->addr;
> +       ctrl->size =3D info->size;
> +       ctrl->type =3D info->type;
> +       ctrl->rcid_count =3D info->rcid_count;
> +
> +       /*
> +        * SRMCFG encodes RCID in 12 bits. Reject an out-of-range count r=
ather
> +        * than silently truncating in every FIELD_PREP(SRMCFG_RCID_MASK,=
 closid)
> +        * on the schedule-in fast path.
> +        */
> +       if (ctrl->rcid_count > FIELD_MAX(SRMCFG_RCID_MASK) + 1) {
> +               pr_warn("CC at %pa has RCID count %u beyond the 12-bit SR=
MCFG field, skipping\n",
> +                       &ctrl->addr, ctrl->rcid_count);
> +               cbqri_controller_destroy(ctrl);
>
Any reason to have explicit cleanups ?

> +               return -EINVAL;
> +       }
> +
> +       ctrl->cache.cache_id =3D info->cache_id;
> +       ctrl->cache.cache_level =3D cache_level;
> +
> +       err =3D cbqri_probe_controller(ctrl);
> +       if (err) {
> +               cbqri_controller_destroy(ctrl);
> +               return err;
> +       }
> +
> +       /*
> +        * Allocation capability comes from the capabilities register pro=
bed
> +        * above, not from device tree. rcid_count only bounds the RCID r=
ange,
> +        * so a controller the hardware reports as alloc-capable but desc=
ribed
> +        * with no RCID count cannot be driven. Reject that inconsistency=
. A
> +        * monitoring-only controller (not alloc_capable) needs no RCID c=
ount.
> +        */
> +       if (ctrl->alloc_capable && !ctrl->rcid_count) {
> +               pr_warn("CC at %pa is alloc-capable but has no RCID count=
, skipping\n",
> +                       &ctrl->addr);
> +               cbqri_controller_destroy(ctrl);
> +               return -EINVAL;
> +       }
> +
> +       guard(mutex)(&cbqri_controllers_lock);
> +
> +       /* The resctrl glue keys its domains on cache_id, one controller =
each. */
> +       list_for_each_entry(other, &cbqri_controllers, list) {
> +               if (other->cache.cache_level =3D=3D cache_level &&
> +                   other->cache.cache_id =3D=3D info->cache_id) {
> +                       pr_warn("CC at %pa duplicates the L%u cache id %u=
 controller at %pa, skipping\n",
> +                               &ctrl->addr, cache_level, info->cache_id,
> +                               &other->addr);
> +                       cbqri_controller_destroy(ctrl);
> +                       return -EEXIST;
> +               }
> +       }
> +
> +       list_add_tail(&ctrl->list, &cbqri_controllers);
> +       return 0;
> +}
> diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_int=
ernal.h
> new file mode 100644
> index 000000000000..9481a9035704
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_internal.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _DRIVERS_RESCTRL_CBQRI_INTERNAL_H
> +#define _DRIVERS_RESCTRL_CBQRI_INTERNAL_H
> +
> +#include <linux/bitfield.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/riscv_cbqri.h>
> +#include <linux/types.h>
> +
> +/* Capacity Controller (CC) MMIO register offsets. */
> +#define CBQRI_CC_CAPABILITIES_OFF 0
> +#define CBQRI_CC_ALLOC_CTL_OFF   24
> +#define CBQRI_CC_BLOCK_MASK_OFF  32
> +
> +/*
> + * Per CBQRI 3.5 the block-mask width BMW is the smallest multiple of 64=
 bits
> + * that holds NCBLKS, so cc_cunits sits at 32 + BMW/8 bytes. This consta=
nt is
> + * valid only while NCBLKS <=3D 64. cbqri_probe_cc() rejects ncblks > 32=
 before
> + * it reads cc_capabilities.CUNITS, forcing BMW to 64 bits, one 8-byte b=
lock
> + * mask, and cc_cunits at 0x28. Raising that cap above 64 would require
> + * computing 32 + roundup(ncblks, 64) / 8 instead of a constant.
> + */
> +#define CBQRI_CC_CUNITS_OFF      40
> +
> +/*
> + * Highest base register offset (cc_block_mask at 0x20) plus its 8-byte =
width.
> + * cbqri_probe_controller() rejects smaller mappings. cc_cunits at 0x28 =
is
> + * optional and only required when cc_capabilities.CUNITS is set, which
> + * cbqri_probe_cc() checks against the mapping size separately.
> + */
> +#define CBQRI_CTRL_MIN_REG_SPAN  0x28u
> +
> +#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK_ULL(3, 0)
> +#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK_ULL(7, 4)
> +#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK     GENMASK_ULL(23, 8)
> +#define CBQRI_CC_CAPABILITIES_CUNITS_MASK     BIT_ULL(25)
> +
> +/*
> + * CC control registers are 64-bit, but the CBQRI spec only guarantees
> + * single-copy atomicity for naturally aligned 4-byte accesses. They are=
 read
> + * as two 32-bit halves (cbqri_readq) reconstructed into a u64 for field
> + * extraction, and written via the low 32-bit half, so the driver does n=
ot
> + * depend on native 64-bit MMIO. Keep every field mask GENMASK_ULL so
> + * FIELD_MODIFY() or ~mask on the reconstructed u64 never zero-extends a
> + * 32-bit mask and clobbers STATUS/BUSY/WPRI in bits 63:32.
> + */
> +#define CBQRI_CONTROL_REGISTERS_OP_MASK      GENMASK_ULL(4, 0)
> +#define CBQRI_CONTROL_REGISTERS_AT_MASK      GENMASK_ULL(7, 5)
> +/* AT field values (CBQRI Table 1): data vs code half for CDP */
> +#define CBQRI_CONTROL_REGISTERS_AT_DATA      0
> +#define CBQRI_CONTROL_REGISTERS_AT_CODE      1
> +#define CBQRI_CONTROL_REGISTERS_RCID_MASK    GENMASK_ULL(19, 8)
> +#define CBQRI_CONTROL_REGISTERS_STATUS_MASK  GENMASK_ULL(38, 32)
> +#define CBQRI_CONTROL_REGISTERS_BUSY_MASK    GENMASK_ULL(39, 39)
> +
> +#define CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT 1
> +#define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
> +#define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
> +
> +/* Capacity Controller hardware capabilities */
> +struct riscv_cbqri_capacity_caps {
> +       u16 ncblks;
> +       bool supports_alloc_at_code;
> +       /* cc_capabilities.CUNITS: controller enforces a capacity-unit li=
mit */
> +       bool cunits;
> +};
> +
> +/**
> + * struct cbqri_cc_config - desired capacity allocation state for one rc=
id
> + * @cbm:         capacity block mask
> + * @at:          AT half the @cbm applies to (CBQRI_CONTROL_REGISTERS_AT=
_DATA
> + *               or CBQRI_CONTROL_REGISTERS_AT_CODE)
> + * @cdp_enabled: when false and the controller supports AT, mirror @cbm
> + *               into the other AT half so both stay in sync
> + */
> +struct cbqri_cc_config {
> +       u64  cbm;
> +       u32  at;
> +       bool cdp_enabled;
> +};
> +
> +struct cbqri_controller {
> +       void __iomem *base;
> +       /*
> +        * Serializes the write-then-poll-busy MMIO sequences on this
> +        * controller. Each CBQRI op may busy-wait up to 1 ms on slow
> +        * firmware, so use a sleeping mutex to keep preemption enabled.
> +        * All resctrl-arch entry points run in process context.
> +        */
> +       struct mutex lock;
> +
> +       struct riscv_cbqri_capacity_caps cc;
> +
> +       bool alloc_capable;
> +
> +       phys_addr_t addr;
> +       phys_addr_t size;
> +       enum cbqri_controller_type type;
> +       u32 rcid_count;
> +
> +       struct list_head list;
> +
> +       struct cache_controller {
> +               u32 cache_level;
> +               /* Cache id used as the resctrl domain id */
> +               u32 cache_id;
> +       } cache;
> +};
> +
> +extern struct list_head cbqri_controllers;
> +extern struct mutex cbqri_controllers_lock;
> +
>
Can these be made static in cbqri_devices.c and provide API for cbqri_resct=
rl.c?

Thanks,
Sunil
