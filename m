Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FDF49C4C3
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824057; cv=pass; b=OOX29dz6rgrPCumnoDx5n2VijJAVI0+3U7iIeIspl8VoToctkCUIW+AO0BmF+a6+0/FPGXlGKNAdxcEhtrT5Mtp7WreRKEP7UOJg8BloZmDfFg4gxjawxDslNzfVOvK61e7He66ElM+aYDilklayeQO2EKdr6CNT+gG9W6Juz9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824057; c=relaxed/simple;
	bh=1WFnP6jLwkphePEVwQzzC2movqMZe7VpOgeibgbUA+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m60/x4UkPf/AkmH9Fa1aIDxsd5/Y+8n4Nv9aMhVbq7mGTbIPYEPSnUyFbPGzvX8mEMXSwsZkuNx1V2aDSqGVH/NlJbXjiuGQ7a4iVX6M1AKO8U9WcrZm9OKeF9lwysKmvLJifdQR/GNopX3aGsB/GJjjxOzdZy2yQ6UUMLICkhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NnjIw3qZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FfoFffwl; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NnjIw3qZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfoFffwl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFescW3272314
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=ZAn70o2CsvEcko82mtVgPFR/QKt84XQwH/IoqK3O5+c=; b=Nn
	jIw3qZbfIUXtJbFs/yf+wiO8izZzqh393OilItZyzZs+ambmke6Aj4KoG6rma6gN
	o70hauk0DfaNYtUZ7mhkXL0UoSk/GxIh7ZC2n6ktI9HaAoLXTBnxRlWphi2lvot1
	F8OfVr5YiR2zg669weYGqnsQm0l3o0gIofyK1HxF+13lqRVB9IoAUQ2IoOzltrSl
	/PtuvE4rXAdh+PRP5+0sp2mxJ/49/9j6gE99Rn9ERXzWt6X3+ystpMJgzFyJQ0YG
	NDS3VMWij7QTPDvv6YNiRxgSfKPJ3h6ckGjyCNRxF+Xf8Dc5ofK+ceW9s3Yb7d6+
	kpxWVxilUgBXNCq8yZzQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffht5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 16:54:12 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-677d10671b7so2588531d50.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 09:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791824052; cv=none;
        d=google.com; s=arc-20260327;
        b=oDZV5inDheA8lEqf+rj5nhuN7TUB9Bbheoef/OKSkIljhzYcxZXxY/M43i1veE4HeE
         fWDvUFNDAAFR2AAzIuafv4HLiRfIZVYkQXrApcobQnvAspOYndrRrquiD2YmBOrpBGVH
         z4AAtkK5KqFtEvkMp1VY/LSL/c4mLeSCiHE1xcffLorK3gOqFShYvzK1GPDrAJ6Hh+oD
         on451pvS4nU87TpzqoMypoiHWwdonj5+ztdydpxeHD1TITbVXkni73YPaYYluay3re2H
         zLzYWSX6+3wQu1+KKN6pktQ29RWufng0k2mcO8P10l13D6kEvgyhbX7OBmUR0paKXCDJ
         j/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=ZAn70o2CsvEcko82mtVgPFR/QKt84XQwH/IoqK3O5+c=;
        fh=oszc5QYxy+FB8owb6eEzHsUYuQDbayAMaFlLl3oigtU=;
        b=dJkPgL9PN2ESjyBHFdcGCrd81VDxCvkLvOeM2iXrSqZLXR2pfg2V0QGUaVxryO2vFW
         D09bgWXsFfDUBvDmGZL/+M/29Q8GnNL9zP5uaZrAJDc+n5hVPyKT0VNXjJl4LWjszp1h
         0gtiaJ75x/bd2jUiFrRb3Z1CnHql/FwT6YNE9Hz1/Yhg/OEeBOVtzpkL2yuogd9z/5tn
         +AdoaDt01uTNtBwiTvIr9k5NDM9kzm33D3gF8P+Xaao7zO4j5WGYqB5IhpB84vQGYqJy
         f3I3HiPBipicFCH5lGaBf9yQu82j7O9ewIw/2M8CJammYL12mZQG2JxDdaKwcFBDDmck
         osOg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791824052; x=1792428852; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZAn70o2CsvEcko82mtVgPFR/QKt84XQwH/IoqK3O5+c=;
        b=FfoFffwlC6xA2tISH/6wH9hspA5cCPRGLx6+UEo8sXjrMeJ4q2dwZ+WP5UbN88Y6Np
         rHK8dUFXWum90K4lDwO6WWUeRMfDkl8NuaSs8XwQOk/aGRG15h0h1XaQXH5M9WVSw2D0
         g6IacUi53cAh6AWx+UI85QvezOZPznAPvXo4HDsXIHwliOAJ9ntzyIA/1N+YjqKAoai3
         kUMulHgg2OdLBZbixTMueB6LIDk4xcbpJSfq+wPmoDsoxn7NXypCbfTyGNrim7ABAgA6
         BFk0T7rAugXXO2w0iHY4HvKyfcgYM+ssOKt+83w+ghKCkFO5Gcb89ReY846toJWMm1sf
         cIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824052; x=1792428852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAn70o2CsvEcko82mtVgPFR/QKt84XQwH/IoqK3O5+c=;
        b=OCOJ/osJZWvhG9HUqvE6FF21os9/o0+gQYw42omgmxZfGFpqViKo8hzsmDjXVy0Xf6
         zgtarzhiajxWYMHZKBit+YEMfwePqSWdZe502jG+LNEC2TBb96kNCrzbQl16MtOVLYA1
         gV/8/cfcASain2S9jU1mJlvYoZgOd9rM0k6y+9ugeWpxYkbOS1wuOCD69gdpXtA2yj8m
         NDbEb2bZ4Q7aH+BzCPFxq+YC++Ba61b+BHc4utq6GJ60q2a+xmOdLiRkAFRmohIIsDtC
         VHva0iDdh8CTVlbl8P8CF3zxrmr31rysSdxs6bIg/eFvUvnnokwH4/GuYe9XMMjHTCgL
         fTmg==
X-Forwarded-Encrypted: i=1; AKwUvBxtL7lBOZ8Tg0IhGr4GtaWTf+7XEYyI1WIT3/PT3BCvZlkUhgJ1T648VzF/rrsDeFyv7NXZfrXF+4y9AzBHlg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJoQx5SL99KnwQlVFCafeSccG3trD+g2Ik+Me/F8h8h7xzfUAAr
	hp4ktQViOeMHnLRzCsvvBlUvwErR7U/Z+Qtb4zd7cTw4LDBtCgs/g98DBu1lDG0sciXHCq15B9i
	0LbexrBfmbY4HXZXRArkAJitZ1hpmHjYJbp4EIUhCnz4qj9nxN3lFttvjx1vDfgdgO/gcXCpwdU
	3l7FMSnjvHR8I3vV2aSANUISwHjiQHpsfF8TD4y6FPpVZt
X-Gm-Gg: AYBFou3/d18nGuvd+XipjUQHRmEuNiZeZdjp1/RyvoBNee8GA1swIleFBZlAW7Wwv5T
	e7ob+gqlK+5d2kZBKyAh9QjN8dVIPOeygrjipEOM5x2sCE6l8M1e4U5xbbJHBztPyDmjmVcAacB
	QE7kKxMItqwilS5ER4ts4D7QTTX2NFRLUgPtOLM1nrUTWbWFJ4PYicJ1c0+PM=
X-Received: by 2002:a53:da43:0:b0:677:dc7e:48c5 with SMTP id 956f58d0204a3-67936769395mr2422419d50.10.1791824051396;
        Mon, 12 Oct 2026 09:54:11 -0700 (PDT)
X-Received: by 2002:a53:da43:0:b0:677:dc7e:48c5 with SMTP id
 956f58d0204a3-67936769395mr2422404d50.10.1791824050641; Mon, 12 Oct 2026
 09:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003-dfustini-atl-sc-cbqri-dt-v9-0-52fd8be98dcf@kernel.org> <20261003-dfustini-atl-sc-cbqri-dt-v9-2-52fd8be98dcf@kernel.org>
In-Reply-To: <20261003-dfustini-atl-sc-cbqri-dt-v9-2-52fd8be98dcf@kernel.org>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 22:23:57 +0530
X-Gm-Features: AclHuK_pJmyKcx-GDhRF_u294AVebgJlV7gCanZzlS0meDPGni4-QpkJuU5JCzk
Message-ID: <CAB19ukEkAOMnPpi2jVFz68GZ_7cwYmNtrBkxnfEJtFcPb7PJ5Q@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NyBTYWx0ZWRfX4O5eaxo64mvY
 QZPBe8RhWFV6t7JPK4crkxIB0Q3FIQAo9PWJscordNwguXkuO0nCL0hELPXj+nrTg3Bl9XLZg1h
 Buk4zcJJl0BjvnZxyzW0g/OmgDxgTTOAlrx3bVjPC44R3Upo1FBiJ6ZaILu9cDxMHiCfL4fXdUU
 yUnfCIYb+W1UyG6PJ8ks26jEOxqEBZqKYpJiokESeaton3zbvPi+4p47LewaO26lgL8kcstZiEQ
 8MQ02kDZjPJ7hzN820jfY+ZqASaKNXOKdjlNNe8ipMdzuoIwymkOGwP0ACSAKAbggmihDha+0KD
 /R300Z9tCeZMHhC+MF0kBXbNaOMk2E4OYqQTmF+sVPjgS5dvts0yCXVd/Hoy1WLxzxMBW+BhGCf
 BTZSnUYduBE7Hymo3lINEzqkz9oFhtXI5vuudmaDIJx8glTNgGnJF20tFH5Xjw9NFRrPmqmkzWH
 5XnnhagWAO+UgdYZfxg==
X-Proofpoint-GUID: WZjlSzwP1bFLt0_1j1PJkIBxufMvRTi2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NyBTYWx0ZWRfX2Z2xHkOcAS3S
 TelIAFoGZJKHp+j0D5GwaOSXPb2jtw11yYhmwYL8roJEP2chW+2tdJMTfepAjkuqoV3navK/R4G
 G4VbkKQ1F6Y2hjZnM8iuKWnolC+6tWM=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acd10b4 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=IpJZQVW2AAAA:8
 a=968KyxNXAAAA:8 a=JfrnYn6hAAAA:8 a=E9ey4MeB8Z-DosR5ckMA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=IawgGOuG5U0WyFbmm1f5:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: WZjlSzwP1bFLt0_1j1PJkIBxufMvRTi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120067

On Sat, Oct 3, 2026 at 12:45=E2=80=AFPM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Wire CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2 and
> RDT_RESOURCE_L3 schemata.
>
> resctrl exposes a single capacity mask per resource, so when more than
> one capacity controller backs a cache level they must report the same
> number of capacity blocks. The same holds for the other capabilities
> resctrl exposes once per resource. A level whose controllers disagree
> is left unexposed. Other levels are unaffected.
>
> The set of controllers backing each level is fixed when resctrl is set
> up at late_initcall. Control domains are created in the cpuhp online
> callback and keyed on the onlining CPU's cache id from cacheinfo, so a
> CPU that is offline at probe time still joins its domain once it comes
> online, provided a controller for its cache is in that set. A CPU whose
> cache has no controller is left out of that level and a warning is
> logged once. A domain is published on the ctrl_domains RCU list only
> after it is fully initialized and brought online, and removed from the
> list before it is taken offline, following the documented safe
> traversal rules.
>
> Assisted-by: LLM
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                      |   2 +
>  arch/riscv/include/asm/resctrl.h | 147 +++++++
>  drivers/resctrl/Kconfig          |   4 +
>  drivers/resctrl/Makefile         |   1 +
>  drivers/resctrl/cbqri_resctrl.c  | 831 +++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 985 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92b111cd25c0..db0799d8cbf8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23570,9 +23570,11 @@ R:     yunhui cui <cuiyunhui@bytedance.com>
>  L:     linux-riscv@lists.infradead.org
>  S:     Supported
>  F:     arch/riscv/include/asm/qos.h
> +F:     arch/riscv/include/asm/resctrl.h
>  F:     arch/riscv/kernel/qos.c
>  F:     drivers/resctrl/cbqri_devices.c
>  F:     drivers/resctrl/cbqri_internal.h
> +F:     drivers/resctrl/cbqri_resctrl.c
>  F:     include/linux/riscv_cbqri.h
>
>  RISC-V RPMI AND MPXY DRIVERS
> diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/re=
sctrl.h
> new file mode 100644
> index 000000000000..867db663d958
> --- /dev/null
> +++ b/arch/riscv/include/asm/resctrl.h
> @@ -0,0 +1,147 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_RISCV_RESCTRL_H
> +#define _ASM_RISCV_RESCTRL_H
> +
> +#include <linux/resctrl_types.h>
> +#include <linux/sched.h>
> +#include <linux/types.h>
> +
> +#include <asm/qos.h>
> +
> +struct rdt_resource;
> +
> +/*
> + * Sentinel "no CLOSID assigned" used by resctrl_arch_rmid_idx_decode().
> + * fs/resctrl treats this opaquely. CBQRI uses MCID directly as the line=
ar
> + * rmid index, so closid is unused on decode.
> + */
> +#define RISCV_RESCTRL_EMPTY_CLOSID     ((u32)~0)
> +
> +/*
> + * Terminology mapping between x86 (Intel RDT/AMD QoS) and RISC-V:
> + *
> + *  CLOSID on x86 is RCID on RISC-V
> + *    RMID on x86 is MCID on RISC-V
> + *     CDP on x86 is AT (access type) on RISC-V
> + */
> +
> +/**
> + * resctrl_arch_alloc_capable() - any CBQRI controller exposes resctrl a=
lloc
> + *
> + * True while at least one resource set up by cbqri_resctrl_setup() has
> + * rdt_resource::alloc_capable set, so it gives the same answer as walki=
ng
> + * the resources. Only meaningful after late_initcall.
> + */
> +bool resctrl_arch_alloc_capable(void);
> +
> +/**
> + * resctrl_arch_mon_capable() - any CBQRI controller exposes resctrl mon=
itoring
> + *
> + * The CBQRI driver implements capacity allocation only and wires up no
> + * monitoring events, so this always returns false. fs/resctrl reference=
s it
> + * unconditionally, hence the stub.
> + */
> +bool resctrl_arch_mon_capable(void);
> +
> +/**
> + * resctrl_arch_rmid_idx_encode() - encode (RCID, MCID) into a linear in=
dex
> + * @closid: RCID (resource control id)
> + * @rmid:   MCID (monitoring counter id)
> + *
> + * RISC-V uses MCID directly as the linear index into per-RMID arrays
> + * managed by fs/resctrl, since CBQRI controllers admit any MCID for any
> + * RCID. closid is unused here. CDP is encoded via the AT field on each
> + * CBQRI op rather than via the index.
> + */
> +u32  resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid);
> +
> +/**
> + * resctrl_arch_rmid_idx_decode() - inverse of resctrl_arch_rmid_idx_enc=
ode()
> + * @idx:    linear index
> + * @closid: out: always RISCV_RESCTRL_EMPTY_CLOSID
> + * @rmid:   out: the MCID that @idx encodes
> + */
> +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid);
> +
> +/**
> + * resctrl_arch_set_cpu_default_closid_rmid() - install per-CPU srmcfg d=
efault
> + * @cpu:    CPU number
> + * @closid: RCID to use when no task is matched
> + * @rmid:   MCID to use when no task is matched
> + *
> + * Sets the per-CPU cpu_srmcfg_default so __switch_to_srmcfg() can fall =
back
> + * to the CPU's default RCID/MCID for default-group tasks (those whose
> + * thread.srmcfg encodes to 0, i.e. closid =3D=3D RESCTRL_RESERVED_CLOSI=
D and
> + * rmid =3D=3D RESCTRL_RESERVED_RMID). Implements resctrl allocation rul=
e 2
> + * ("CPU default") on RISC-V.
> + */
> +void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 r=
mid);
> +
> +/**
> + * resctrl_arch_sched_in() - context-switch hook to install task RCID/MC=
ID
> + * @tsk: the task being scheduled in
> + *
> + * Called from finish_task_switch() to write tsk->thread.srmcfg into the
> + * srmcfg CSR. Tasks tagged with RISCV_RESCTRL_EMPTY_CLOSID inherit the
> + * per-CPU default set via resctrl_arch_set_cpu_default_closid_rmid().
> + */
> +void resctrl_arch_sched_in(struct task_struct *tsk);
> +
> +/**
> + * resctrl_arch_set_closid_rmid() - tag a task with an RCID/MCID
> + * @tsk:    task to tag
> + * @closid: RCID to install
> + * @rmid:   MCID to install
> + *
> + * Updates tsk->thread.srmcfg with the encoded (RCID, MCID) pair. The ne=
w
> + * value takes effect on the next resctrl_arch_sched_in() for this task.
> + */
> +void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u=
32 rmid);
> +
> +/**
> + * resctrl_arch_match_closid() - test whether a task carries a given RCI=
D
> + * @tsk:    task
> + * @closid: RCID
> + */
> +bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid);
> +
> +/**
> + * resctrl_arch_match_rmid() - test whether a task carries a given (RCID=
, MCID)
> + * @tsk:    task
> + * @closid: RCID
> + * @rmid:   MCID
> + */
> +bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rm=
id);
> +
> +/**
> + * resctrl_arch_mon_ctx_alloc() - allocate per-monitor-event arch contex=
t
> + * @r:     resctrl resource being monitored
> + * @evtid: which monitor event needs context
> + *
> + * The CBQRI driver implements no monitoring events, so there is no per-=
event
> + * context to allocate and the stub returns NULL. fs/resctrl references =
it
> + * unconditionally before checking resctrl_arch_mon_capable().
> + */
> +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, enum resctrl_ev=
ent_id evtid);
> +
> +/**
> + * resctrl_arch_mon_ctx_free() - release context returned by mon_ctx_all=
oc()
> + * @r:            resctrl resource
> + * @evtid:        monitor event id
> + * @arch_mon_ctx: pointer returned by resctrl_arch_mon_ctx_alloc()
> + */
> +void resctrl_arch_mon_ctx_free(struct rdt_resource *r, enum resctrl_even=
t_id evtid,
> +                              void *arch_mon_ctx);
> +
> +static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
> +{
> +       return val;
> +}
> +
> +/* Not needed for RISC-V */
> +static inline void resctrl_arch_enable_mon(void) { }
> +static inline void resctrl_arch_disable_mon(void) { }
> +static inline void resctrl_arch_enable_alloc(void) { }
> +static inline void resctrl_arch_disable_alloc(void) { }
> +
> +#endif /* _ASM_RISCV_RESCTRL_H */
> diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
> index 1219fb29aa2e..cac23d20124b 100644
> --- a/drivers/resctrl/Kconfig
> +++ b/drivers/resctrl/Kconfig
> @@ -38,3 +38,7 @@ menuconfig RISCV_CBQRI
>           RISC-V cache QoS resources. CBQRI exposes cache capacity
>           allocation through the resctrl filesystem at /sys/fs/resctrl wh=
en
>           RESCTRL_FS is also enabled.
> +
> +config RISCV_CBQRI_RESCTRL_FS
> +       bool
> +       default y if RISCV_CBQRI && RESCTRL_FS
> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
> index 4d8a2c4b5627..a7631712dba9 100644
> --- a/drivers/resctrl/Makefile
> +++ b/drivers/resctrl/Makefile
> @@ -6,3 +6,4 @@ ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)       +=3D -DDE=
BUG
>
>  obj-$(CONFIG_RISCV_CBQRI)                      +=3D cbqri.o
>  cbqri-y                                                +=3D cbqri_device=
s.o
> +cbqri-$(CONFIG_RISCV_CBQRI_RESCTRL_FS)         +=3D cbqri_resctrl.o
> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resc=
trl.c
> new file mode 100644
> index 000000000000..f10a24761b25
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c
> @@ -0,0 +1,831 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/bitfield.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/cleanup.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufeature.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/rculist.h>
> +#include <linux/resctrl.h>
> +#include <linux/riscv_cbqri.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <asm/csr.h>
> +#include <asm/qos.h>
> +
> +#include "cbqri_internal.h"
> +
> +struct cbqri_resctrl_res {
> +       /*
> +        * Capacity controllers picked for this resource at late_initcall=
,
> +        * one per cache instance at its level. cbqri_resctrl_pick_caches=
()
> +        * only accepts a set that agrees on the capabilities resctrl exp=
oses
> +        * once per resource, so ctrls[0] speaks for all of them.
> +        */
> +       struct cbqri_controller **ctrls;
> +       unsigned int            nr_ctrls;
> +       struct rdt_resource     resctrl_res;
> +       bool                    cdp_enabled;
> +};
> +
> +struct cbqri_resctrl_dom {
> +       struct rdt_ctrl_domain  resctrl_ctrl_dom;
> +       struct cbqri_controller *hw_ctrl;
> +};
> +
> +static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCE=
S];
> +
> +/* Protects ctrl_domain list mutations across CPU hotplug. */
> +static DEFINE_MUTEX(cbqri_domain_list_lock);
> +
> +/*
> + * Look up the ctrl_domain with this id. When there is none and pos is
> + * given, pos receives the list position a new domain with this id has t=
o
> + * be inserted before, so the caller can add it without a second walk.
> + */
> +static struct rdt_ctrl_domain *
> +cbqri_find_ctrl_domain(struct list_head *h, int id, struct list_head **p=
os)
> +{
> +       struct rdt_domain_hdr *hdr =3D resctrl_find_domain(h, id, pos);
> +
> +       return hdr ? container_of(hdr, struct rdt_ctrl_domain, hdr) : NUL=
L;
> +}
> +
> +/* The picked controller backing cache instance cache_id, or NULL. */
> +static struct cbqri_controller *
> +cbqri_resctrl_find_ctrl(const struct cbqri_resctrl_res *hw_res, u32 cach=
e_id)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < hw_res->nr_ctrls; i++) {
> +               if (hw_res->ctrls[i]->cache.cache_id =3D=3D cache_id)
> +                       return hw_res->ctrls[i];
> +       }
> +
> +       return NULL;
> +}
> +
> +/* Map a hardware cache level to its resctrl resource id, or -ENODEV. */
> +static int cbqri_cache_level_to_rid(u32 cache_level)
> +{
> +       switch (cache_level) {
> +       case 2:
> +               return RDT_RESOURCE_L2;
> +       case 3:
> +               return RDT_RESOURCE_L3;
> +       default:
> +               return -ENODEV;
> +       }
> +}
> +
> +static int cbqri_apply_cache_config_dom(struct cbqri_resctrl_dom *hw_dom=
,
> +                                       struct rdt_resource *r,
> +                                       u32 closid, enum resctrl_conf_typ=
e t,
> +                                       u64 cbm)
> +{
> +       struct cbqri_resctrl_res *hw_res =3D
> +               container_of(r, struct cbqri_resctrl_res, resctrl_res);
> +       struct cbqri_cc_config cfg =3D {
> +               .cbm =3D cbm,
> +               .at =3D (t =3D=3D CDP_CODE) ? CBQRI_CONTROL_REGISTERS_AT_=
CODE :
> +                                       CBQRI_CONTROL_REGISTERS_AT_DATA,
> +               .cdp_enabled =3D hw_res->cdp_enabled,
> +       };
> +
> +       return cbqri_apply_cache_config(hw_dom->hw_ctrl, closid, &cfg);
> +}
> +
> +/* True while at least one picked resource offers capacity allocation. *=
/
> +static bool cbqri_resctrl_any_alloc_capable(void)
> +{
> +       int rid;
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++) {
> +               if (cbqri_resctrl_resources[rid].resctrl_res.alloc_capabl=
e)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +bool resctrl_arch_alloc_capable(void)
> +{
> +       return cbqri_resctrl_any_alloc_capable();
> +}
> +
> +bool resctrl_arch_mon_capable(void)
> +{
> +       return false;
> +}
> +
> +bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level rid)
> +{
> +       if (rid !=3D RDT_RESOURCE_L2 && rid !=3D RDT_RESOURCE_L3)
> +               return false;
> +       return cbqri_resctrl_resources[rid].cdp_enabled;
> +}
> +
> +int resctrl_arch_set_cdp_enabled(enum resctrl_res_level rid, bool enable=
)
> +{
> +       struct cbqri_resctrl_res *cbqri_res;
> +
> +       if (rid !=3D RDT_RESOURCE_L2 && rid !=3D RDT_RESOURCE_L3)
> +               return -ENODEV;
> +
> +       cbqri_res =3D &cbqri_resctrl_resources[rid];
> +       if (!cbqri_res->resctrl_res.cdp_capable)
> +               return -ENODEV;
> +
> +       cbqri_res->cdp_enabled =3D enable;
> +       return 0;
> +}
> +
> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
> +{
> +       if (l >=3D RDT_NUM_RESOURCES)
> +               return NULL;
> +
> +       return &cbqri_resctrl_resources[l].resctrl_res;
> +}
> +
> +bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
> +{
> +       return false;
> +}
> +
> +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
> +                                enum resctrl_event_id evtid)
> +{
> +       return NULL;
> +}
> +
> +void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
> +                              enum resctrl_event_id evtid, void *arch_mo=
n_ctx)
> +{
> +}
> +
> +void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_l3_mon_=
domain *d,
> +                             enum resctrl_event_id evtid, u32 rmid, u32 =
closid,
> +                             u32 cntr_id, bool assign)
> +{
> +}
> +
> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_l3_mon_dom=
ain *d,
> +                          u32 unused, u32 rmid, int cntr_id,
> +                          enum resctrl_event_id eventid, u64 *val)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
> +{
> +       return false;
> +}
> +
> +int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable=
)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_l3_mon_d=
omain *d,
> +                            u32 unused, u32 rmid, int cntr_id,
> +                            enum resctrl_event_id eventid)
> +{
> +}
> +
> +bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
> +{
> +       return false;
> +}
> +
> +int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +void resctrl_arch_mon_event_config_read(void *info)
> +{
> +}
> +
> +void resctrl_arch_mon_event_config_write(void *info)
> +{
> +}
> +
> +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_m=
on_domain *d)
> +{
> +}
> +
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_d=
omain *d,
> +                            u32 unused, u32 rmid, enum resctrl_event_id =
eventid)
> +{
> +}
> +
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr=
 *hdr,
> +                          u32 closid, u32 rmid, enum resctrl_event_id ev=
entid,
> +                          void *arch_priv, u64 *val, void *arch_mon_ctx)
> +{
> +       return -ENODATA;
> +}
> +
> +/*
> + * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
> + *   CLOSID on x86 is RCID on RISC-V
> + *     RMID on x86 is MCID on RISC-V
> + *
> + * schemata_list_add() halves this count when CDP is enabled because a
> + * CDP CLOSID takes two hardware IDs on x86. CBQRI selects the code or
> + * data allocation with the AT field next to the RCID, so every CLOSID
> + * resctrl hands out under CDP is already a distinct RCID and the RCIDs
> + * from rcid_count/2 upward sit idle. Skipping the halving would need an
> + * fs/resctrl change, so it is left as is.
> + */
> +u32 resctrl_arch_get_num_closid(struct rdt_resource *res)
> +{
> +       struct cbqri_resctrl_res *hw_res;
> +
> +       hw_res =3D container_of(res, struct cbqri_resctrl_res, resctrl_re=
s);
> +
> +       if (!hw_res->nr_ctrls)
> +               return 0;
> +
> +       return hw_res->ctrls[0]->rcid_count;
> +}
> +
> +u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +       return 1;
> +}
> +
> +u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
> +{
> +       return rmid;
> +}
> +
> +void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
> +{
> +       *closid =3D RISCV_RESCTRL_EMPTY_CLOSID;
> +       *rmid =3D idx;
> +}
> +
> +void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 r=
mid)
> +{
> +       u32 srmcfg =3D FIELD_PREP(SRMCFG_RCID_MASK, closid) |
> +                    FIELD_PREP(SRMCFG_MCID_MASK, rmid);
> +
> +       WRITE_ONCE(per_cpu(cpu_srmcfg_default, cpu), srmcfg);
> +}
> +
> +void resctrl_arch_sched_in(struct task_struct *tsk)
> +{
> +       __switch_to_srmcfg(tsk);
> +}
> +
> +void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u=
32 rmid)
> +{
> +       u32 srmcfg =3D FIELD_PREP(SRMCFG_RCID_MASK, closid) |
> +                    FIELD_PREP(SRMCFG_MCID_MASK, rmid);
> +
> +       WRITE_ONCE(tsk->thread.srmcfg, srmcfg);
> +}
> +
> +void resctrl_arch_sync_cpu_closid_rmid(void *info)
> +{
> +       struct resctrl_cpu_defaults *r =3D info;
> +
> +       lockdep_assert_preemption_disabled();
> +
> +       if (r) {
> +               resctrl_arch_set_cpu_default_closid_rmid(smp_processor_id=
(),
> +                                                        r->closid, r->rm=
id);
> +       }
> +
> +       resctrl_arch_sched_in(current);
> +}
> +
> +bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
> +{
> +       return FIELD_GET(SRMCFG_RCID_MASK, READ_ONCE(tsk->thread.srmcfg))=
 =3D=3D closid;
> +}
> +
> +bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rm=
id)
> +{
> +       return FIELD_GET(SRMCFG_MCID_MASK, READ_ONCE(tsk->thread.srmcfg))=
 =3D=3D rmid;
> +}
> +
> +void resctrl_arch_pre_mount(void)
> +{
> +       /* All controllers discovered at boot via late_initcall. Nothing =
to do. */
> +}
> +
> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_doma=
in *d,
> +                           u32 closid, enum resctrl_conf_type t, u32 cfg=
_val)
> +{
> +       struct cbqri_resctrl_dom *dom;
> +
> +       dom =3D container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_do=
m);
> +
> +       if (!r->alloc_capable)
> +               return -EINVAL;
> +
> +       switch (r->rid) {
> +       case RDT_RESOURCE_L2:
> +       case RDT_RESOURCE_L3:
> +               return cbqri_apply_cache_config_dom(dom, r, closid, t, cf=
g_val);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
> +{
> +       struct resctrl_staged_config *cfg;
> +       enum resctrl_conf_type t;
> +       struct rdt_ctrl_domain *d;
> +       int err =3D 0;
> +
> +       /* Walking r->ctrl_domains, ensure it can't race with cpuhp */
> +       lockdep_assert_cpus_held();
> +
> +       list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +               for (t =3D 0; t < CDP_NUM_TYPES; t++) {
> +                       cfg =3D &d->staged_config[t];
> +                       if (!cfg->have_new_ctrl)
> +                               continue;
> +                       err =3D resctrl_arch_update_one(r, d, closid, t, =
cfg->new_ctrl);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +       return err;
> +}
> +
> +u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_doma=
in *d,
> +                           u32 closid, enum resctrl_conf_type type)
> +{
> +       struct cbqri_resctrl_dom *hw_dom;
> +       struct cbqri_controller *ctrl;
> +       u32 at;
> +       u32 val;
> +       int err;
> +
> +       hw_dom =3D container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl=
_dom);
> +       ctrl =3D hw_dom->hw_ctrl;
> +       val =3D resctrl_get_default_ctrl(r);
> +
> +       if (!r->alloc_capable)
> +               return val;
> +
> +       switch (r->rid) {
> +       case RDT_RESOURCE_L2:
> +       case RDT_RESOURCE_L3:
> +               at =3D (type =3D=3D CDP_CODE) ? CBQRI_CONTROL_REGISTERS_A=
T_CODE :
> +                                         CBQRI_CONTROL_REGISTERS_AT_DATA=
;
> +               err =3D cbqri_read_cache_config(ctrl, closid, at, &val);
> +               if (err < 0)
> +                       val =3D resctrl_get_default_ctrl(r);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return val;
> +}
> +
> +void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
> +{
> +       u32 num_closid =3D resctrl_arch_get_num_closid(r);
> +       struct rdt_ctrl_domain *d;
> +       enum resctrl_conf_type t;
> +       u32 default_ctrl;
> +       u32 i;
> +
> +       lockdep_assert_cpus_held();
> +
> +       if (!num_closid)
> +               return;
> +
> +       default_ctrl =3D resctrl_get_default_ctrl(r);
> +
> +       list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +               for (i =3D 0; i < num_closid; i++) {
> +                       for (t =3D 0; t < CDP_NUM_TYPES; t++) {
> +                               int rerr;
> +
> +                               rerr =3D resctrl_arch_update_one(r, d, i,=
 t, default_ctrl);
> +                               if (rerr)
> +                                       pr_err_ratelimited("rid=3D%d rese=
t RCID %u type %u failed (%d)\n",
> +                                                          r->rid, i, t, =
rerr);
> +                       }
> +               }
> +       }
> +}
> +
> +static struct rdt_ctrl_domain *cbqri_new_domain(struct cbqri_controller =
*ctrl)
> +{
> +       struct cbqri_resctrl_dom *hw_dom;
> +       struct rdt_ctrl_domain *domain;
> +
> +       hw_dom =3D kzalloc_obj(*hw_dom, GFP_KERNEL);
> +       if (!hw_dom)
> +               return NULL;
> +
> +       hw_dom->hw_ctrl =3D ctrl;
> +       domain =3D &hw_dom->resctrl_ctrl_dom;
> +
> +       INIT_LIST_HEAD(&domain->hdr.list);
> +
> +       return domain;
> +}
> +
> +static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_=
ctrl_domain *d)
> +{
> +       u32 num_closid =3D resctrl_arch_get_num_closid(r);
> +       enum resctrl_conf_type t;
> +       int err =3D 0;
> +       u32 i;
> +
> +       for (i =3D 0; i < num_closid; i++) {
> +               /*
> +                * Seed both DATA and CODE staged slots so a later mount
> +                * with -o cdp does not see stale CODE values.
> +                * On non-AT controllers cbqri_cc_alloc_op() masks AT to =
0
> +                * so all three iterations land on the same hardware stat=
e.
> +                * The redundant writes are harmless.
> +                */
> +               for (t =3D 0; t < CDP_NUM_TYPES; t++) {
> +                       err =3D resctrl_arch_update_one(r, d, i, t,
> +                                                     resctrl_get_default=
_ctrl(r));
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +       return 0;
> +}
> +
> +/*
> + * Two capacity controllers at the same cache level are interchangeable =
to
> + * resctrl only if they expose identical caps, since resctrl publishes o=
ne
> + * set of caps per rid but any of the level's controllers may service a
> + * given RCID.
> + */
> +static bool cbqri_cc_caps_agree(const struct cbqri_controller *a,
> +                               const struct cbqri_controller *b)
> +{
> +       return a->rcid_count =3D=3D b->rcid_count &&
> +              a->cc.ncblks =3D=3D b->cc.ncblks &&
> +              a->cc.supports_alloc_at_code =3D=3D b->cc.supports_alloc_a=
t_code &&
> +              a->alloc_capable =3D=3D b->alloc_capable;
> +}
> +
> +/* An alloc-capable capacity controller at the cache level rid stands fo=
r. */
> +static bool cbqri_ctrl_backs_rid(const struct cbqri_controller *ctrl, in=
t rid)
> +{
> +       return ctrl->type =3D=3D CBQRI_CONTROLLER_TYPE_CAPACITY &&
> +              ctrl->alloc_capable &&
> +              cbqri_cache_level_to_rid(ctrl->cache.cache_level) =3D=3D r=
id;
> +}
> +
> +/*
> + * Walk cbqri_controllers once and keep, per cache level (L2/L3), every
> + * capacity controller (CC) that backs the corresponding RDT_RESOURCE_L*=
.
> + * When more than one CC sits at the same level (e.g. one per socket) th=
ey
> + * must agree on rcid_count / ncblks / supports_alloc_at_code, since res=
ctrl
> + * exposes a single set of caps per rid. A level whose controllers disag=
ree
> + * is dropped, but the other level is still picked. Controllers register=
ed
> + * after this walk are not part of any set and resctrl never sees them.
> + */
> +static int cbqri_resctrl_pick_caches(void)
> +{
> +       struct cbqri_controller *ctrl;
> +       int rid;
> +
> +       guard(mutex)(&cbqri_controllers_lock);
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++) {
> +               struct cbqri_resctrl_res *hw_res =3D &cbqri_resctrl_resou=
rces[rid];
> +               unsigned int n =3D 0;
> +
> +               list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +                       if (cbqri_ctrl_backs_rid(ctrl, rid))
> +                               n++;
> +               }
> +               if (!n)
> +                       continue;
> +
> +               hw_res->ctrls =3D kcalloc(n, sizeof(*hw_res->ctrls), GFP_=
KERNEL);
> +               if (!hw_res->ctrls)
> +                       return -ENOMEM;
> +
> +               list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +                       if (!cbqri_ctrl_backs_rid(ctrl, rid))
> +                               continue;
> +
> +                       if (hw_res->nr_ctrls &&
> +                           !cbqri_cc_caps_agree(hw_res->ctrls[0], ctrl))=
 {
> +                               pr_err("L%u controllers have mismatched c=
apabilities, skipping this level\n",
> +                                      ctrl->cache.cache_level);
> +                               kfree(hw_res->ctrls);
> +                               hw_res->ctrls =3D NULL;
> +                               hw_res->nr_ctrls =3D 0;
> +                               break;
> +                       }
> +
> +                       hw_res->ctrls[hw_res->nr_ctrls++] =3D ctrl;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Fill the rdt_resource fields for one picked rid. An rid with no picke=
d
> + * controller is left untouched so it stays out of resctrl_arch_get_reso=
urce().
> + */
> +static void cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_r=
es)
> +{
> +       struct rdt_resource *res =3D &cbqri_res->resctrl_res;
> +       struct cbqri_controller *ctrl;
> +
> +       if (!cbqri_res->nr_ctrls)
> +               return;
> +       ctrl =3D cbqri_res->ctrls[0];
> +
> +       switch (res->rid) {
> +       case RDT_RESOURCE_L2:
> +       case RDT_RESOURCE_L3:
> +               res->name =3D (res->rid =3D=3D RDT_RESOURCE_L2) ? "L2" : =
"L3";
> +               res->schema_fmt =3D RESCTRL_SCHEMA_BITMAP;
> +               res->ctrl_scope =3D (res->rid =3D=3D RDT_RESOURCE_L2) ?
> +                                   RESCTRL_L2_CACHE : RESCTRL_L3_CACHE;
> +               res->cache.cbm_len =3D ctrl->cc.ncblks;
> +               res->cache.shareable_bits =3D 0;
> +               res->cache.min_cbm_bits =3D 1;
> +               res->cache.arch_has_sparse_bitmasks =3D false;
> +               res->cdp_capable =3D ctrl->cc.supports_alloc_at_code;
> +               res->alloc_capable =3D ctrl->alloc_capable;
> +               INIT_LIST_HEAD(&res->ctrl_domains);
> +               INIT_LIST_HEAD(&res->mon_domains);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +/*
> + * Create, list-insert, and online a fresh ctrl_domain backing ctrl on
> + * resource res, seeded with cpu and identified by dom_id. Caller must
> + * hold cbqri_domain_list_lock, must have already verified that no
> + * existing ctrl_domain on res carries this id, and passes the list
> + * position cbqri_find_ctrl_domain() returned for it as pos.
> + */
> +static struct rdt_ctrl_domain *cbqri_create_ctrl_domain(struct cbqri_con=
troller *ctrl,
> +                                                       struct rdt_resour=
ce *res,
> +                                                       unsigned int cpu,=
 int dom_id,
> +                                                       struct list_head =
*pos)
> +{
> +       struct rdt_ctrl_domain *domain;
> +       int err;
> +
> +       domain =3D cbqri_new_domain(ctrl);
> +       if (!domain)
> +               return ERR_PTR(-ENOMEM);
> +
> +       cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
> +       domain->hdr.id =3D dom_id;
> +       domain->hdr.type =3D RESCTRL_CTRL_DOMAIN;
> +       domain->hdr.rid =3D res->rid;
> +
> +       err =3D cbqri_init_domain_ctrlval(res, domain);
> +       if (err)
> +               goto free;
> +
> +       err =3D resctrl_online_ctrl_domain(res, domain);
> +       if (err)
> +               goto free;
> +
> +       /*
> +        * Publish only after the domain is fully initialized and online,=
 so a
> +        * reader walking the RCU list never sees a half-built domain.
> +        */
> +       list_add_tail_rcu(&domain->hdr.list, pos);
> +
> +       return domain;
> +free:
> +       kfree(container_of(domain, struct cbqri_resctrl_dom, resctrl_ctrl=
_dom));
> +       return ERR_PTR(err);
> +}
> +
> +/*
> + * Remove a CPU from the domain at each level whose cache it shares. The
> + * domain is looked up by the CPU's own cache id and the lookup returns =
NULL
> + * if it is already gone, so this is idempotent and undoes a partial onl=
ine
> + * attach as well as a full offline. Caller holds cbqri_domain_list_lock=
.
> + */
> +static void cbqri_detach_cpu_from_all_ctrls(unsigned int cpu)
> +{
> +       static const u32 levels[] =3D { 2, 3 };
> +       struct cbqri_resctrl_res *hw_res;
> +       struct rdt_ctrl_domain *d;
> +       struct rdt_resource *res;
> +       struct cacheinfo *ci;
> +       int i, rid;
> +
> +       lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(levels); i++) {
> +               ci =3D get_cpu_cacheinfo_level(cpu, levels[i]);
> +               if (!ci)
> +                       continue;
> +
> +               rid =3D cbqri_cache_level_to_rid(levels[i]);
> +               hw_res =3D &cbqri_resctrl_resources[rid];
> +               if (!hw_res->nr_ctrls)
> +                       continue;
> +
> +               res =3D &hw_res->resctrl_res;
> +               d =3D cbqri_find_ctrl_domain(&res->ctrl_domains, ci->id, =
NULL);
> +               if (!d)
> +                       continue;
> +
> +               cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
> +               if (cpumask_empty(&d->hdr.cpu_mask)) {
> +                       list_del_rcu(&d->hdr.list);
> +                       synchronize_rcu();
> +                       resctrl_offline_ctrl_domain(res, d);
> +                       kfree(container_of(d, struct cbqri_resctrl_dom,
> +                                          resctrl_ctrl_dom));
> +               }
> +       }
> +}
> +
> +/*
> + * Attach a CPU to the picked capacity controller at each cache level wh=
ose
> + * cache the CPU shares. On failure, detach the CPU from everything atta=
ched
> + * so far: the cpuhp core does not run this state's offline teardown whe=
n
> + * its startup fails, so a partial attach would otherwise leak into the
> + * domain cpu_masks. Caller holds cbqri_domain_list_lock.
> + */
> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +       static const u32 levels[] =3D { 2, 3 };
> +       struct cbqri_resctrl_res *hw_res;
> +       struct cbqri_controller *ctrl;
> +       struct rdt_ctrl_domain *d;
> +       struct list_head *pos;
> +       struct cacheinfo *ci;
> +       int i, rid;
> +
> +       lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(levels); i++) {
> +               ci =3D get_cpu_cacheinfo_level(cpu, levels[i]);
> +               if (!ci)
> +                       continue;
> +
> +               rid =3D cbqri_cache_level_to_rid(levels[i]);
> +               hw_res =3D &cbqri_resctrl_resources[rid];
> +               if (!hw_res->nr_ctrls)
> +                       continue;
> +
> +               ctrl =3D cbqri_resctrl_find_ctrl(hw_res, ci->id);
> +               if (!ctrl) {
> +                       pr_warn_once("no L%u controller for cache id %u, =
CPU %u is not controlled at this level\n",
> +                                    levels[i], ci->id, cpu);
> +                       continue;
> +               }
> +
> +               d =3D cbqri_find_ctrl_domain(&hw_res->resctrl_res.ctrl_do=
mains,
> +                                          ci->id, &pos);
> +               if (d) {
> +                       cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +                       continue;
> +               }
> +
> +               d =3D cbqri_create_ctrl_domain(ctrl, &hw_res->resctrl_res=
, cpu,
> +                                            ci->id, pos);
> +               if (IS_ERR(d)) {
> +                       cbqri_detach_cpu_from_all_ctrls(cpu);
> +                       return PTR_ERR(d);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/* Undo cbqri_resctrl_setup(). Only reached before resctrl_init() succee=
ded. */
> +static void cbqri_resctrl_teardown(void)
> +{
> +       int rid;
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++) {
> +               struct cbqri_resctrl_res *hw_res =3D &cbqri_resctrl_resou=
rces[rid];
> +
> +               kfree(hw_res->ctrls);
> +               hw_res->ctrls =3D NULL;
> +               hw_res->nr_ctrls =3D 0;
> +               hw_res->cdp_enabled =3D false;
> +               hw_res->resctrl_res.alloc_capable =3D false;
> +               hw_res->resctrl_res.cdp_capable =3D false;
> +       }
> +}
> +
> +static int cbqri_resctrl_setup(void)
> +{
> +       int rid;
> +       int err;
> +
> +       for (rid =3D 0; rid < RDT_NUM_RESOURCES; rid++)
> +               cbqri_resctrl_resources[rid].resctrl_res.rid =3D rid;
> +
Why can't cbqri_resctrl_control_init directly use
cbqri_resctrl_resources? I feel this initialization is redundant.

Thanks,
Sunil
