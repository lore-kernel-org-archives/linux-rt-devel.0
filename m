Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C54E4B1B24
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824243; cv=pass; b=Ymgx2JV6VMG55hZnUu4k7T6tmecSjj7OUJxt1sRRHLVuQZoGcbyZhT592yg2MArbLP1R1ddAgMPr5YoNggNHLOIjiTFAr5Y270/R4+9CfucHdPgCzRiVjfnW9i+2GCXi6Hiv1EtyY2/pun9JxadJrWpWLAHCUZ7Epfl7RL9I4HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824243; c=relaxed/simple;
	bh=1ZwHYEL9zk034YEl/vwY1GKXAdewDQli4AdtYssr/d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9LQDlOTS5kPEvLZ9wXBGu++LeMCi0F2hudB0nR7YHh0Q52RxswIPu6q6FrQJY6emyl+8KbYri0Yv88QK8UhW6Z8QnMXB7NPTgWR80Tq+3uo9wrq0shztIaH3xiMfSmSvECf0W2S0Fe+oPa+0NE4jE7QgLWpS0WILodJhjxSDas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMDcUL45; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aHidiXfv; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMDcUL45";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aHidiXfv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFerSj3851202
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=47NuF1ZKqF7d8RYJGYljqA1U0z0Tidrq15wAPG9h8b0=; b=cM
	DcUL45gRuVzE+jNsv8a6qBEwW0YUaXRh4vF8WElxOOIgmMZzaRhY7ruPaoFvy6Lj
	qDSvQ0X0lFxTBwq6zbVb2UUqBCDF+64fcrSBck2BgsxfSY0aPjBI59yBV9SemnuF
	jg4xUoWeLZnUS8rUWRyWRBQFNxDXxI+uZPwLVKKE6Kt+ibWKP7ABv1Vqabb8hEvt
	LktCsN/FQJeSEwTezqgfkoea1A8vPmr2HuWNFVu5BbJA0I7kjDSw9H39g0Z1+HjA
	trgQ6uybg3jafppp73YBth9ts2UVWUjjpterLmYN7VhiHYf/TQTofM+iER1ldPCv
	VDxuL8ErBKA16yDFyp5w==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wdr9u1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:57:18 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-675d5613a31so2428685d50.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 09:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791824237; cv=none;
        d=google.com; s=arc-20260327;
        b=lnTJYsnh9AQz6PUjF3Hir1YlEQU0EW5Q8gWBcBcHRiGmoLcUDbQSeWY2Ovh4Fb9LSX
         ni9usKqZXy+H08YfMU9hrggUQussFj3sFgQ2Kpyvrum8UXxrZTkY3u9hovxau2JQJ4zT
         jHFsKlxvk1GKgF6FputhCF4Z3Q/cdIbxP2VyCaMnj6PTsN5Ozk1g4gjRjY5ZXefrvjM7
         zGg2rF0m3sHyIbv5dBUJrwPu2dOHU7UYnexLBxV3ILm4lk9LvujeekFjnsC5Dxq6tcsl
         Z3EMsrY0Mz0SWm+0OQkJXwcg67HpzZhgbJ0auJrq9kb2bi7de5r1fRG5lh0YKHDVWEqG
         t2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=47NuF1ZKqF7d8RYJGYljqA1U0z0Tidrq15wAPG9h8b0=;
        fh=HgAOOnvIXLUuqFvKZbvgAtcIFG6JoUCBewfTjOAMWY0=;
        b=ag8PGC5V4Oc5O9gbEJbsXbzfoQeVJdT7auaUNayDYPM7l9WiSuccR36ULRernnfYu/
         SouTJWVYlLSgnW1qYR/muf8Q0KYtPeatRmZeydlCHfuICmBwvqNsk0dm1cUY7foZiC3V
         CV8zXayZ/cmzg5xYCqxUfG1V8tFKYWFemmGgzmAhPWTjbp+nESW9SvoU5ToznIijooFJ
         Gx1gJqyT5DZoQGn/1AYJnjqIKghJkGhKJtklsYJZKZzAbzRXdktx2S5pyD/srZSOVbZl
         Ir1XBGdeLXbJ1Ly7HOxPZlX0UoQJfbOH1+ymwEWugE1mblwG71p2yDd1mylvwcv9Uxah
         ePoQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791824237; x=1792429037; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=47NuF1ZKqF7d8RYJGYljqA1U0z0Tidrq15wAPG9h8b0=;
        b=aHidiXfvdaVBkW2z+cijHGvfxM+uIaHP8GGZ1XxtjAjiwWXlHP5L0g4uCd2XPGCpts
         uvPsi5MskWpH1cPCVNAgBhN7Sy/cPFY8YK0O7JWeRPw/FH2R/lsOeUD1p+mIN7crb27/
         TDxl+ciKDzDJf0/HRLA/vmMqzPN+MBvLNlB7zoHISCtelVkJQ496MHjJVfqJESuWlNr3
         kP9kKAIij2cua8yogzYXAQWwLNgPTtMgUaWekF30Xh143fI+mBiim1V+P97KQW+LJKzR
         VcgxX5wp8wDz2JbeaNBLLi0DAWR7W8HUbvhqnatWMLy0+EstI7KuDg78Xc550bWqgIdz
         1CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824237; x=1792429037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47NuF1ZKqF7d8RYJGYljqA1U0z0Tidrq15wAPG9h8b0=;
        b=foqmduIesX1ilaYf47IYgeHil84TzsF1gGOMu0I+JHXGgc2Az0/1fE1ApMKFP/TPUg
         baS/v7/bKz3nuseXGzbO6nsdodTNLzZjE1iOVlFTlTpk2z5LOSF3m8MRJsnXB709lY1i
         c9wm58KfnQIOQAFxRQgduG6IEZ1j82Gth/ndZeESvcHUCtXolyMNngmK6o+Fhsc4S6N5
         lx1Ra/bkpKuO1xpVyZwJwBVupmpiULXjo6ny/NwxliWO1O1z6OTb/kUAkxkXImRnDTEn
         IqzdYaVkzvK6jhu+am+GLBEZsSf88QwQzHK2TfmWqOvTfVtRsG5J1GClzSeAiyAuzPvA
         cxkg==
X-Forwarded-Encrypted: i=1; AKwUvBzriXQ33ZnI3dSu6KbFL5SsihCdq3+w6/zoQoDDSDf2ga5AfIVxSrIEzk5OrAX6ntoRatwFDxUY8yybrX0kkg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI/gUuq7uxGUPCbuuJxKyB8MAVrx1oOElUvpm5oCbxDDv67YlsP
	mPFt0ZjkJm3vZ9q0fAfln4iwBprjY/X2xC3KxO0sAK1dz46oHU2Xq/DA19b9wQUhA4EorUWB3K0
	Ouy/nV+SLtxINJ8f/gQfOCGnhzd7KR8pUxXmFrrl/gLUy5QMspV+btBIe+DkH7d49nyDeYgH5P1
	dsUt6p+wBIfxtInZpeZvFBHc4TU7xgrYTX9dCrX7u7QQ6/
X-Gm-Gg: AYBFou3EFEJ2lu9Thi8kMWICbEg+0F87OdNLW7TDaBDFMWtVhRVaflHZQgJ5KN1SU9s
	bnmATWRooRJHy1G9tErkEIAcAkjN+sqLV2SjC5bVOOrW3Hn4FXRa7h8PEzGae1gDvuxI0XAp0Ee
	EeAY0y140oRzpbSazIMdL7JwtqpvnncP5xuCaWueeHeAik+OfrpIOcdW4TGyM=
X-Received: by 2002:a05:690e:4101:b0:676:88cd:477a with SMTP id 956f58d0204a3-679360586ebmr2314592d50.64.1791824237278;
        Mon, 12 Oct 2026 09:57:17 -0700 (PDT)
X-Received: by 2002:a05:690e:4101:b0:676:88cd:477a with SMTP id
 956f58d0204a3-679360586ebmr2314577d50.64.1791824236864; Mon, 12 Oct 2026
 09:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org> <20261003-dfustini-atl-sc-cbqri-dt-v9-3-52fd8be98dcf@kernel.org>
In-Reply-To: <20261003-dfustini-atl-sc-cbqri-dt-v9-3-52fd8be98dcf@kernel.org>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:27:04 +0530
X-Gm-Features: AclHuK96lmXU1FySMYulXru_-us2zCYXg_c0cpE2EJ1bHEgD2VYJgCcz2mj0Iv8
Message-ID: <CAB19ukFNjO-J7YaLh3_1dAziMtELkvu6mmVbcES=WFWYQxgnSQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] riscv_cbqri: Make RESCTRL_FS available on RISC-V
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NyBTYWx0ZWRfX/KCkPfB/8DH6
 VyUIwyA1wkgGHjwErcLQELDsenZiK4/CSY3sESmRjN7ZqQv6yYE6ttrmf89vbf3Svxxcmgs8YB6
 D1m4ycVu0fzOREzQDfJwxGiSbRd/Fkv8H2YXEMEE8lUwA0EM3zspX0HhvG7l3tn9V5pckRS90jm
 8i7hyGQosBgcg5m8PBM8DUcOKy2Ut29pLQoTCPFDgabcd3JJItSYOZqTaExGKgeBgaraGU1bxkA
 /DvwXkdbHCAPi8jxhucXhOoQQpcxwx+zBpyj5v3ADL6JDkNWJKZRhKn808n7gfEwTf1bc8CLbyK
 U5sTk+FXILKuBy9R74eCbm8g3WzkCeWN5Qu4u7VU4zFdO0ZHG7TNefOwvRmBoePUZ8ohHUgOyUD
 05aVatE5/+F9npIqLRYx9Rkwo35Kl+Xx+SYdzI4Na122OlN1v03ObecFNM+M49BKR/MIA5kXY4t
 8dzkAMcz6hyg5Rsyv0A==
X-Authority-Analysis: v=2.4 cv=SvAFe/O0 c=1 sm=1 tr=0 ts=6acd116e cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=WVtwwdpmd8cHSuz7VWcA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NyBTYWx0ZWRfX/HHBhH/B4Lum
 2lU6sfEpGie+FGmSSekJBaRGarw6lDDAgtxLX6I5xJzPu2EncaIUxjO/lJMbF509ZrM+7Qt3uTP
 zNUB7UIx6Sf89C33rMtJOM//wX4SfFE=
X-Proofpoint-ORIG-GUID: mq_JC3t1MH_FN1J7oYyU6CZyvyrIQmOC
X-Proofpoint-GUID: mq_JC3t1MH_FN1J7oYyU6CZyvyrIQmOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120067

On Sat, Oct 3, 2026 at 12:45=E2=80=AFPM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Enough CBQRI support is now present to enable ARCH_HAS_CPU_RESCTRL.
> Have RISCV_CBQRI select it so that RESCTRL_FS can be enabled on
> RISC-V, and default RISCV_CBQRI to y. RISCV_ISA_SSQOSID is default n,
> so this only affects kernels where the user has already opted into
> Ssqosid, and on those the CBQRI support is what makes the extension
> useful.
>
> This is a separate patch so that no commit makes RESCTRL_FS selectable
> before the resctrl glue it depends on exists. Enabling the resctrl
> filesystem itself stays a user choice under MISC_FILESYSTEMS.
>
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  drivers/resctrl/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index cac23d20124b..617b813b9808 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -33,6 +33,8 @@ config ARM64_MPAM_RESCTRL_FS
>  menuconfig RISCV_CBQRI
>         bool "RISC-V CBQRI support"
>         depends on RISCV && RISCV_ISA_SSQOSID
> +       select ARCH_HAS_CPU_RESCTRL
> +       default y
>         help
>           Capacity and Bandwidth QoS Register Interface (CBQRI) support f=
or
>           RISC-V cache QoS resources. CBQRI exposes cache capacity
>
LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
