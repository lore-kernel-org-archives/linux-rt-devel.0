Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4E3AC00;
	Wed,  5 Aug 2026 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898032; cv=none; b=TbE+KBKib6l5KTfd0mgIfdSaK0kftHQxaFKqtb8L8k/c1VoG8VU3vO0VIpOYQqhLZLgfaOMHAE81RGqjtnuErfFYjW64kslqSd56QkWtQ/VAxIo1zLA4Ie3qEjT8RWmEzJY8LuAdfxN89kvX2iPAIyOChc/YbkHoSrc9KBULGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898032; c=relaxed/simple;
	bh=oeoetBGFaPUjx7MKWexIh0DScT+b0I+uXQHwKRT1Oec=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sQCiRefUg76O0DzcW5TkuPyulPPlGSCUW08F4GS/VBwj4401nG6qgN1GMxCmjDmVRxX5NW4HBSQzDSyGVfxmaM5j1DHs11+FyXuU9oThxnN4PvmvSxjikVBfaE2NiYgSwyghlVWkjWs6uoPvjIQLn0wBtKPPZ93MReK5ZksPo1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWUowoZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWUowoZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800EB1F000E9;
	Wed,  5 Aug 2026 02:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785898031;
	bh=EuQ7UkVWTzna9OyzZ2ItQq8zDFnsDKDcsmb9afVZaB4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=HWUowoZQFzrsIHAH0KZZfdJetuB3H5S3IdPe4wGbSObpEkSTySeqMLPXmLN7ESTJw
	 ygoMtuoAwrNtHH9czbbMYAFHPqvKW6kz4C+FQZVtGqNhS0uK2j3FrVqlDzzmjc3PVA
	 BJX6jJa4SsrSvSxWdXZBqBq1F2CTNI5wlAUebtlWB9hXndYtiEb37ay2eccWaD1JRu
	 BBJxaas1Pkb0ZY+NL3sTpNVr7Q8UCHWL76k/UxokaLiFzqyOStxvZrrR4wAaiQrvM+
	 YvQv3RH0Sjq2R92jUgTgftFOykKVriS41eBe5MZOj8fabwJ/Kr4oXp5TJ/CY0Sh7S3
	 n8QHnF6+Fr/BA==
Date: Tue, 4 Aug 2026 20:47:04 -0600 (MDT)
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
Subject: Re: [PATCH v6 2/8] riscv: Detect the Ssqosid extension
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-2-7c22b05d461b@kernel.org>
Message-ID: <c38f0bfa-54fc-d141-c166-7355901d8ad1@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org> <20260729-dfustini-atl-sc-cbqri-dt-v6-2-7c22b05d461b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-908076126-1785898031=:1429015"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-908076126-1785898031=:1429015
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 29 Jul 2026, Drew Fustini wrote:

> Ssqosid is the RISC-V Quality-of-Service (QoS) Identifiers specification
> which defines the Supervisor Resource Management Configuration (srmcfg)
> register.
> 
> Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
> Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>

Thanks, queued for v7.3.


- Paul
--8323329-908076126-1785898031=:1429015--
