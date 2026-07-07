Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DC3438B7
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414117; cv=none; b=FrI+QuaMvUJC7787pttU4gU2eZJ/aEB4fOULxUBtExTtFmZ+vtFTv510VHHcW51rrlIK0NOTmfJp7WEUVxPrpPvHSHL7bYmRggCXx8wsvDE+m5hS2Tf2eaeZtJoKhopvMkeE8NclH1nQh/VTjjA1qoAmissVEqeFJ916GqBuCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414117; c=relaxed/simple;
	bh=B7IpEGimiq97mBhe4ez+EoRJVMiEWH0AXP6PlEke+J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpMDFtxiwOA44awSbeo/4Ff7tb4J8MvecSmymYD0vH8qo/fEcPkoGOqCnLHBZq5ieZO+5tGELxx2VLDygpfHjJwGZXXXTQQKW2MybwLLnK+VkTMPSDHaOU0MNWYwvARhpPPlWMdRi7ZHR0xzjoBQ3yB8NfUpjjNlFfzB8bjlsao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Pe/sw5/h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Pe/sw5/h"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4759b4f0897so1727159f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783414114; x=1784018914; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B7IpEGimiq97mBhe4ez+EoRJVMiEWH0AXP6PlEke+J8=;
        b=Pe/sw5/hyQjQPo5uGwlcoIhc4XF4aJK20J3e0IY/bvIFdCphU5+SaWgvct8mKz0PSS
         IC9I0U0tUddXViV4OHAtXTa52KNLRsxHMFTMQdD+AFzBp5B19L4Een8V57g/jbuGaUJ2
         YDy249n+DZhTJft8s3LCCf3AKDTd2Dmj+s5x8+jpRtcd5zNm1sjb1cifIEq/shF9waJB
         J6fUU9ciTEdpOO3kk+t8V2pK5vYmZThL62iNNE5T6Tti3CQjDrCyiID3D4YuAE5iQJdh
         xX6TMLlhiZs76Tescax4cnDrZgNShXkHdGYAWVDFL1aRVrNh72nXgryyEwWmGCyWYqBa
         7muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783414114; x=1784018914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7IpEGimiq97mBhe4ez+EoRJVMiEWH0AXP6PlEke+J8=;
        b=G2QescE+VY0IIvg8LjX0ZuDanLaV2thu7R/sMQbCqQqXBBcfsQhEUHU0jA/o+UCxtT
         hAtnj/IIYxUr0umC5R3++EZPL+TaWNr3a6QijYceTuHU2YOh5lmccubJa4sWlCAR7ViG
         B+l2QEpiVcvAvA/IrtUkpo0FtSTpq/d4epYlRpzLqAiaxWg5grhneLdjcTADIbZfOwwY
         4A+/iajUmaUNcFTTwk+VyonZ4U6fgNqqaEjZO96p105SYF2FycKkKqu/ZF6iVhv5ovF+
         HNrTE1gYu5dQX2gSn4LDEPlW7rgcRazaf/lcak9doav1IL3pbomxEM96kOFIGOtdSQDp
         3RBw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2BbukhPCp5dNrF1cS19qURt3c7LLN2IxXjWFKR0xPSgA2VfAnbBL0fZEV2HWz7tdn50IiMr8RqHQzR1D5fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtsxGzLeHzRFNdcrn4euZzRKNL0rI1Tn6BGareiaGtSEpxjN9w
	BYCOY5Cjyv5Fk+TBnsuM6TxQRXoVtRiO1dfKx3SPZqtjhmLlfx8mkWBTAnLcPPFooF0=
X-Gm-Gg: AfdE7cngJx0WllO75xBo8evlJBFs/n2aJRQy9hN8nhwaMn9lfmtRZdLgDCnrJsNua07
	yU8aWQoqj85m5qBNftRlSYTO+qS4oxg1kV9Q4uYN9SHgVCaETfGykqmn0iPdMzyM75Bf6PdJvGf
	v6fzXNsPis0kSp07OUOGZL5dRMMycU7qmA04uH6RoxJD8i3apjk4IzMJZtCMlSdkTJKxsDopIx8
	cUWiYlCwPowMUG4azq22RMU6mhx/Mr4on8t6O37FPKHHI3asxSDcgwK0jYpKfHptCEIp9lbFN7d
	845M0v1jbiS/VSrlMc5cdpHyyi4Wyk3wAr17kQpdYLg47y1GUW/eYb0ZHqB2s1jsAuHcAxMnnGy
	rkzf8bsk/H54h33OcGGb0hCPGaFHFGLstIrHbpQVW230hfi5efOe9hfIkX20muqm9Bt+bERAmph
	LWobQe+EHA2C7FM2yCxRkgqRilYzP9UO3DNHRolVGjAQFIB9SlYvpCYtXIvwRFXl5twEKaQKW88
	IOH
X-Received: by 2002:a05:6000:25c2:b0:46a:234:d2e with SMTP id ffacd0b85a97d-47de670a006mr4350047f8f.38.1783414114474;
        Tue, 07 Jul 2026 01:48:34 -0700 (PDT)
Received: from localhost (p200300f65f47db0437b4d928ee3eb6f8.dip0.t-ipconnect.de. [2003:f6:5f47:db04:37b4:d928:ee3e:b6f8])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa039ad21sm31630429f8f.20.2026.07.07.01.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 01:48:33 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:48:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Drew Fustini <fustini@kernel.org>
Cc: Adrien Ricciardi <aricciardi@baylibre.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, 
	Borislav Petkov <bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	Fenghua Yu <fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, 
	Gong Shuai <gsh517@gmail.com>, guo.wenjia23@zte.com.cn, James Morse <james.morse@arm.com>, 
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	liu.qingtao2@zte.com.cn, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Peter Newman <peternewman@google.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
	Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
	yunhui cui <cuiyunhui@bytedance.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 8/8] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
Message-ID: <aky9S8A5dgIJjd7b@monoceros>
References: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
 <20260706-dfustini-atl-sc-cbqri-dt-v4-8-e75c20201d64@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qztydshr4q4j5sd4"
Content-Disposition: inline
In-Reply-To: <20260706-dfustini-atl-sc-cbqri-dt-v4-8-e75c20201d64@kernel.org>


--qztydshr4q4j5sd4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 8/8] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
MIME-Version: 1.0

Hello,

On Mon, Jul 06, 2026 at 04:06:18PM -0700, Drew Fustini wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--qztydshr4q4j5sd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpMvV4ACgkQj4D7WH0S
/k6v2AgAl2287/4HQdpHnTug1nV07MMobHFzJ3S4RVStcbqDYYzz13jQz2rZa6De
h3bwnHtKRaWt0KGFus+38vYwJklCFYLbhQN03osh+8lbz0SZFCR2LhqYZ4NqRYpL
7YE7uJZZ0+PC0e8/9zRxAzCm3uUzdWf40hTy2rY73zLaieF5wf3ouGQ9zNNfNT/4
DQhLEXEErGBrZ+bCPvOmHXL8AOtqXFSDLgdQKssqT/pBoQMkcf9ng4DtpeDDwHzc
a6UBUrgNPUSGvwxHGh7hOFxnOUwrrFaQiks6LKJ3T4MLICtMMHBwBulmJXRQKkzz
JEHzbEDCw5lqHMYE4K+SFmz38WjUUA==
=eLlr
-----END PGP SIGNATURE-----

--qztydshr4q4j5sd4--
