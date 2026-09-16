Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C7EEC3;
	Wed, 16 Sep 2026 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518320; cv=none; b=Bjg0wf/zjc4Yx2nkh900lq8NGTguaGHehGYn+AcFAUPMSxUXwiBPSml1INEDr8E8974IZz7FUC1tKUkuRL2CEFRomJskmzBv4gjZM44Q06UYKqGzDeaJbTdKZ4KzP/gOaJN71iySwmDo/N3gGtm5ZCOTwwH1k0ss87U8gr7VwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518320; c=relaxed/simple;
	bh=A0Let5NCg9d9Z9NVPwRMaZTpNOePHVeO3MMV1IFuGtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZqvj3YAUP2wOUsxmmtl5nUz4iSuGIZo/GVV4TKEdoBYMDKMeTqBnuLs1yckh4VlwpKufOQFq+hpayBKAEaej+w5mdgUJVAi7NkCpKYfmLxZN3S+VUPcZhJgJgbL41OrE66vxJd1TzYNn4EyQFsfBMwDVrEwvkAuXWrxaNxNlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTI9RUBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTI9RUBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A301F000FF;
	Wed, 16 Sep 2026 00:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789518319;
	bh=oCoSEk/kdI6Jx/Hs/Ys/2xTpv2gnopuAEfd6oSTk8rU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WTI9RUBBKTus/OejACddjmDt4WpWCJnxpQYbgneSXISSOjPXhkMi94mfL37NWPMvr
	 1t4sJc02jmrYa86lVfMD2LosqN+Y3QDXzzN8U1nO8l1cWGW6hN/UOuJSa2Q/ECKp/n
	 WMZJaNJYaxr4ZIeAZhpAvzsnsoe+56YtJ+Rnze8q+fJglyCZ2bIheyoKyoWQC9L0Rr
	 KZyqPHzhPI9TtNVFpje8aUGKavG68sWrLd7ZnPhiO+CC1pDD0tASaiVQEN9ltvAr+/
	 OEXwJjnDFzR56ZfPJs2PuRyTdgD9Jeew2GJVLtrV2ZWfclOk9B//LU0r5jG1e81iWJ
	 61ujnb0tHDTvA==
Date: Tue, 15 Sep 2026 17:25:18 -0700
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
Subject: Re: [PATCH net-next v2 6/8] net: xilinx: tsn: add the endpoint RX
 data path
Message-ID: <20260915172518.09e66147@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-6-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
	<20260909-patches_v2_external-v2-6-3a40babaff4c@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 00:49:54 +0530 Srinivas Neeli wrote:
> +	guard(spinlock_bh)(&xchan->rx_lock);

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
