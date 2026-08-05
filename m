Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F1377A88;
	Wed,  5 Aug 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956446; cv=none; b=rGa6b8YTclC050eylR6z1ZrKqqGxJtIQsepY9hnUteyQ984YwxVsT72vNlaEdm6IGGPRwhihyHwWi00LnkQ3a6V3/Gby2jYOMQaNH53I23TnVMqibwnQOxNlbJfByujjoI1W3cCYPFeucPH8OCqQ7PsBfemc61u4+riLRzPps2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956446; c=relaxed/simple;
	bh=wUDMwDCj/hgH0HlkYKasSuvAU9tVV0SdKHtXSyl1Ixw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IX/66G7ExDA7JaChBp6fcBih3SHmOekBxqpOuS0FLs9lDlkzXcETsQAtwsrtJ0SEbGnnr6ytMS8R32/PRr1kBBY7nd8sMO6PeFDMvfoY/lCP1qr/hizoNo3bi9WvQaGO1ma4mypPUOYYdSeceP4ko1B8SsoIs7rVGRrYY7B8Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EglE+9Ls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EglE+9Ls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D8B1F00A3D;
	Wed,  5 Aug 2026 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785956445;
	bh=wMYZA8AlNf6gM6blefRnFi0tolDoOtoUkOg6Cmqg2aw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EglE+9LsA5r4LSKWNFGFi14ZsG2EApotl29OUDOp5NhSnIXJq65XBDLFDh5v65Yq2
	 UlUetjdKKn4pWe+h82SDIUsFQIL5wGiULklf1b2DOK4jnYis/cQLzyiJ26idib/el5
	 GhUBq64SuCW8mgp6O+rZOxNj+8JPYFNQpATNJXP2otMDZz3FvQ6+DBbyzOg4MJkdBr
	 GwewxRculi6CFeluwVrI4dPY+jMC2Q+yQ5Diti73SKpeD/8DVFgwfMfpJ+BW46hrHc
	 UVQY74Vw31ZEE0ZmzHAfp5geBZUrn4yDoJvijbtBuffaYVo3QeEQsZ1VnPe1VntRZH
	 N76Iiq7Uqf20Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56933392FFC3;
	Wed,  5 Aug 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/8] riscv: Add Ssqosid and initial CBQRI resctrl
 support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178595640491.488016.3217391264979488942.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 19:00:04 +0000
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: linux-riscv@lists.infradead.org, aricciardi@baylibre.com, alex@ghiti.fr,
 atishp@rivosinc.com, atish.patra@linux.dev, babu.moger@amd.com,
 ben.horgan@arm.com, bp@alien8.de, cp0613@linux.alibaba.com,
 conor.dooley@microchip.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 Dave.Martin@arm.com, fenghuay@nvidia.com, gong.shuai@sanechips.com.cn,
 gsh517@gmail.com, guo.wenjia23@zte.com.cn, james.morse@arm.com,
 mindal@semihalf.com, krzk+dt@kernel.org, liu.qingtao2@zte.com.cn,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, pjw@kernel.org,
 peternewman@google.com, rkrcmar@ventanamicro.com, reinette.chatre@intel.com,
 robh@kernel.org, samuel.holland@sifive.com, bigeasy@linutronix.de,
 tony.luck@intel.com, vasu@rivosinc.com, ved@rivosinc.com,
 liwei1518@gmail.com, cuiyunhui@bytedance.com,
 zhangzhanpeng.jasper@bytedance.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-doc@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 29 Jul 2026 18:11:27 -0700 you wrote:
> [NOTE: only patches 4 and 8 are different in v6]
> 
> This series adds initial RISC-V QoS support: the Ssqosid extension [1]
> (srmcfg CSR), the CBQRI controller interface [2] integrated with resctrl
> [3], and a DT-based platform driver for cache controllers. It has been
> tested on both the Tenstorrent Ascalon Shared Cache controller and a QEMU
> implementation [4].
> 
> [...]

Here is the summary with links:
  - [v6,1/8] dt-bindings: riscv: Add Ssqosid extension description
    (no matching commit)
  - [v6,2/8] riscv: Detect the Ssqosid extension
    (no matching commit)
  - [v6,3/8] riscv: Add support for srmcfg CSR from Ssqosid extension
    https://git.kernel.org/riscv/c/3cfa79f25467
  - [v6,4/8] riscv_cbqri: Add capacity controller probe and allocation device ops
    (no matching commit)
  - [v6,5/8] riscv_cbqri: resctrl: Add cache allocation via capacity block mask
    (no matching commit)
  - [v6,6/8] riscv: Enable resctrl filesystem for Ssqosid
    (no matching commit)
  - [v6,7/8] dt-bindings: riscv: Add binding for CBQRI controllers
    (no matching commit)
  - [v6,8/8] riscv_cbqri: Add CBQRI capacity allocation platform driver
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


