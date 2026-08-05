Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE33AC00;
	Wed,  5 Aug 2026 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898011; cv=none; b=QEfm03VS5p7rvJ0vEoDkJtNOqq7nmMWNTtvymvPFpKp8zECUSHd6Hh8fEqusGnlAuqIoM9oMygQtKa3+l9hh0ShpDsxlBeH0yMy1+BsXV6FZjMgP6LSAz0L9NbQUhM77M46LyekwdQad0IHGkYSXg98G1yEXCmwYwTnLgup1OYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898011; c=relaxed/simple;
	bh=anDmmYmDCw85dJdG5F1r05td0cG0ll5ir6h6ibLQk5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VsVDAbkLs3F68gQEtDz7Hndl0xCpfcs3YXnKDQbMVt6MgmLWXg+3pkEls8nBZB1PgoenkPKjs6ciLU217REcFYZW4SBqN/ZtID1qkxAwrckE5qOsxCjEHRHwpHSuuadPHePnKppOXHa6r3mPwFnlD5bBarqMH+2gpV3i5KceQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md2voIh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md2voIh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295501F000E9;
	Wed,  5 Aug 2026 02:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785898009;
	bh=anDmmYmDCw85dJdG5F1r05td0cG0ll5ir6h6ibLQk5Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=md2voIh7SHArpmBf3q4HUy7wT+dp8MyfuKgWe70PZGwm9zg8GTsSISge1OGz0Dvay
	 Cyy6QcZ7bKEV8MBUYudZskpMWyDjQYiQUkOfW3gmfVuI+zp4wJepzFaN9yUrN7cZiV
	 06a8WwYxF/QIhHnuiDDhWRl0+onya9B3hwfV03aSwa8Nc10zLIHk9UVExrWZcbiFES
	 0LoCfxM9GHxx3M5ma2l5gpaz8o3Kq9qfRrRb6ouF2KJ3bCOspfPFFW2NlR5QXzusKB
	 BdBPsv/u4Db42cNl3bppRMo1EvkfYRfTMncaYGoLAoBfX4Bo3VzG9uWPvsajpyIFEU
	 cZiDtUj1q4NJQ==
Date: Tue, 4 Aug 2026 20:46:39 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Drew Fustini <fustini@kernel.org>
cc: Adrien Ricciardi <aricciardi@baylibre.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
    Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
    Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
    Chen Pei <cp0613@linux.alibaba.com>, 
    Conor Dooley <conor.dooley@microchip.com>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>, 
    Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
    guo.wenjia23@zte.com.cn, James Morse <james.morse@arm.com>, 
    =?ISO-8859-2?Q?Kornel_Dul=EAba?= <mindal@semihalf.com>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn, 
    Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
    Peter Newman <peternewman@google.com>, 
    =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@ventanamicro.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
    Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
    yunhui cui <cuiyunhui@bytedance.com>, 
    Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
    linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
    x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 1/8] dt-bindings: riscv: Add Ssqosid extension
 description
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-1-7c22b05d461b@kernel.org>
Message-ID: <8d9a90e2-37c5-f1d6-edc4-9531942aaa35@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org> <20260729-dfustini-atl-sc-cbqri-dt-v6-1-7c22b05d461b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Jul 2026, Drew Fustini wrote:

> Document the ratified Supervisor-mode Quality of Service ID (Ssqosid)
> extension v1.0.

Thanks, queued for v7.3.


- Paul
