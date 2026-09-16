Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934EE3C141A;
	Wed, 16 Sep 2026 23:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603056; cv=none; b=dGwfopFmpKMrVMefXNHQGQJvTfOva+zOl/wTjQf/7lVrLf3xTuHeOr1KhDP57qINXtd1ePdHX+/cSbQ+mZIsP5axB9ot3pSJ+zUUmDhfZxTai2qgMvRM7lfiY5VY/VDBlUzJp6COmSeOTA0lYsUlJG7XN+olB4y/Q+Bf9Q73YSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603056; c=relaxed/simple;
	bh=DLieBuqPVyH/HKi26RvJcWHyCXxPKjOInGo7fhpCOUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3SmnX+w2KSJ54ggURxQFUsdUXRadYxZIq/QLR8DXDWwejlBuE4Rc1zB5HfU5Pz15zglpf+KndB3acaxA9h3EokM4YaaIqZbGDV4yjrQB8hBK4XK6RArAf2RpcgI1kNT7N4Vq4mHnosssLKptfxz6IwRR8lyzGlwHUFpkZ3TtUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/DMyAUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/DMyAUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB0F1F000FF;
	Wed, 16 Sep 2026 23:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789603055;
	bh=qYakI41YOepUCc8Ox+8Jq/FeqJw1dMrVoS2gQCRrOmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g/DMyAUfIuO+zZ4KVeJlkf2CXBHROPnONq8wvWi9xtEHbmPQHI3R2V+YC41W4sh0T
	 ek9xnCTFj5uoKxcDTBnYJsu9T7KVTCBFTZcpHYR/Sd5NW6fPM4P1ttvnZ4uYQYa5nY
	 Wuh5Czk0aIs+QpuUQ6FqvACgxaTY7TBZd4KAc0QTEV+y2o/zMTloDXPLbfKwH46bmw
	 zjLEwxXooqkKtJhd6Jnek/YP1gTI6ATU9BiSuYbxiHFgK9YyDFNZeLDOkWHFechVf9
	 rIr/XX/xdoh5sRsn5YW6VFRzNDMkJYTLulXD8O+B/gZK3uPj0lnkfePoJQX1rI5bp7
	 1XivUqq/hAr9Q==
Date: Wed, 16 Sep 2026 16:57:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Neeli, Srinivas" <srneeli@amd.com>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>, Nagadheeraj Rottela
 <nagadheeraj.rottela@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Subject: Re: [PATCH net-next v2 0/8] Add Xilinx TSN Endpoint Ethernet MAC
 driver
Message-ID: <20260916165731.19ff3f94@kernel.org>
In-Reply-To: <cab3aede-940d-4ebb-80ac-41f4755d6d78@amd.com>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
	<20260915172232.04df37b2@kernel.org>
	<cab3aede-940d-4ebb-80ac-41f4755d6d78@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 13:31:26 +0530 Neeli, Srinivas wrote:
> On the data path, DSA maps onto the hardware cleanly. On RX, the EP DMA 
> path delivers the source port in sideband metadata, which feeds DSA's 
> existing metadata-based
> demultiplexing to the per-port netdevs. On TX, the normal data path has 
> no destination-port selector and the switch has no independent per-port 
> forwarding mask, so
> standalone isolation is done with a private VLAN containing only the 
> selected port and the EP. The next version uses DSA's tag_8021q helpers 
> to manage those VLANs, insert
> the destination port's VLAN tag (which the hardware strips before wire 
> egress), and handle the transitions between standalone and bridged 
> operation.

Oh, well, that probably makes DSA justifiable here.
Please provide more details in the cover letter for v3.
Given the TSN focus I was expecting that the "EP" will
have the ability to apply metadata to control the treatment
of the egress packets, but sounds like quite the opposite :(
