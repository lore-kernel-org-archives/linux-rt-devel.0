Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1621A447;
	Wed, 16 Sep 2026 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518155; cv=none; b=MwXFqKxonJRpf4K74MMfbGCeBHLURGsBaLwm1qg5z79tdldqM9llsVvJQvTcs2dj94ofvR/KhTNsPSKosmGrQgVC3vQHe0g2ynA2xUP5oQy2/cbbENJQGDDthXOXqdcG0+6mICK/xGDi2sxUqkWbjfARCQw1wHvwHDA97N4tNzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518155; c=relaxed/simple;
	bh=tfp/H+PVQL+YpSv9kw+OGp9L0SGjpXNu9tZynIhcIic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyOjMRSqCT1h3fxV/yKIOEYZpf5cQgR/wK6b4mm05yNgjtzvrBW4C2hr4LhemOUzsz8Zxn5hrLrAgEtc7exuPy86kBiMPksGz9dTCPHRDNbIZ60tWZNCukzjKktAqZEEDkwkJMhqlNvx2LqXpNfwtkSnXCBK5+A6HEOr0lRhipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FemkOq0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FemkOq0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CBD1F00893;
	Wed, 16 Sep 2026 00:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789518154;
	bh=H8DSLS94/4rn/IDEYTvnb/3NOSmuiboyBVGoAfDceNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FemkOq0Cn++Rtx1GJ2eUSVXAfe6MyPicArFasJFuqHZgwSVWAp53cdkoCx5f/63cT
	 shPokNu2TsUSWSNW/WCLm9QAB7Ov+0sCMaAtrLUeR2YKNwAlOwhRT2She0oZfQhiwG
	 cGY8qvxYkpAApkOGVj4rUJrSIbghNY7endSgCyJmAbe9V4C9BjKXggM98XB5MWXUzZ
	 GZpFF46WwlYgeqpJtqPhHYy28AXSPOcYQ/vuFGcoMHVqQMjFmGOKkRnWy1vA30KWZx
	 l+ZACWWDaZ3ayDG6Gax8c0mXqPgaTBCkHxscSItqjDXeSvUwmx0qdtEhHtfQh/IcgX
	 lNeeKGvr9Cc/Q==
Date: Tue, 15 Sep 2026 17:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Srinivas Neeli <srinivas.neeli@amd.com>
Cc: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Michal Simek <michal.simek@amd.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>,
 <neelisrinivas18@gmail.com>, <git@amd.com>
Subject: Re: [PATCH net-next v2 0/8] Add Xilinx TSN Endpoint Ethernet MAC
 driver
Message-ID: <20260915172232.04df37b2@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 00:49:48 +0530 Srinivas Neeli wrote:
> This series adds the wrapper and endpoint side of the IP. The switch-facing
> part is exposed through the Distributed Switch Architecture (DSA) framework
> in a follow-up series, so that MAC1 and MAC2 show up to Linux as switch
> ports with the endpoint acting as the CPU/conduit port. The endpoint frames
> are already classified by source-port id and tagged with DSA port metadata
> here, so the switch series can consume them without further endpoint
> change.

I'm not sure why you're implementing this as DSA.
This needs to be explained, if a single driver can bind and control 
the whole thing, that's AFAIU preferable. You can keep the
implementation details in the driver without exposing the conduit
to user space
