Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A72264A9;
	Mon,  4 May 2026 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938781; cv=none; b=H1e6OCL7FPH68jyjpRbEDgKdcgacTs75WYbUFhL7O3XQB4DPxpP0BTlG6+Khr5NUlM1gQX35HsfHVX2ILDiqWJMT5En6jorvBeUrph1MP9yXrUisUoCLtTNw7J/2zjFSxJOL5llxyt2EVZzE0Q7fzR28JazCI+UiAcf/LzN1QW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938781; c=relaxed/simple;
	bh=KAOd1V9M6ZWqHCSjDNjv4F8nmp8wTumJhk0Vw3mgNZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFk+6mTWv9GLivU29MSNSHy3YQ1r7RIMCdXgWE+U7BLDXAqeNVOEJgFZkYtwCv0kDuqo8GUYn25gO8tx8qRrgAXLTXrrGuyTRmfRgRYYINlobdTv0TRCljy0fhdr4tKtkFyEqGw60i0CXEExursSmtyO0KK2rrTAAKK89HPOx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8uWwS7Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8uWwS7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C2FC2BCB8;
	Mon,  4 May 2026 23:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777938781;
	bh=KAOd1V9M6ZWqHCSjDNjv4F8nmp8wTumJhk0Vw3mgNZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u8uWwS7Qzn6wA7JSIKsO0sKF2G+VlRXqBQsxSe4/fk6fahgfaVOW656JguZiNUqKS
	 5DI3BzNywNszZ40oGTo4QRBrzSBkYXrkofQAgNUt2mCNgeNas0njNZz69IMCg65Btp
	 mvTgVaMcx5+wQXbFZagAhoVv/l+WlDwpF3KelSs+X2TRsa00lydA4dz1J5jsuqSA4T
	 4vkf6nMFPbzHSA/66+CjKd0leHCoJmWc3K1cWmQ/2Skquvu0YHLt6PCdDmQF96DxlQ
	 RROPDH/Gp1CrLd8pZryGatPE9Oy76gKptmGL6wQXWBrPjdo0MaA0bLXfeptNxCvEAR
	 QcwJBcsO5earw==
Date: Mon, 4 May 2026 16:52:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 <UNGLinuxDriver@microchip.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
 <bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net 2/4] net: sparx5: fix sleep in atomic context in MAC
 table access
Message-ID: <20260504165258.30b81158@kernel.org>
In-Reply-To: <20260504-misc-fixes-sparx5-lan969x-v1-2-6604306b5743@microchip.com>
References: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
	<20260504-misc-fixes-sparx5-lan969x-v1-2-6604306b5743@microchip.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 16:43:43 +0200 Daniel Machon wrote:
> sparx5_mact_learn() is called from .ndo_set_rx_mode with
> netif_addr_lock_bh held, but takes sparx5->lock which is a mutex.
> A mutex may block, which is not allowed from atomic context.

Could you try to switch to the recently added ndo_set_rx_mode_async?
We added it exactly because most drivers have to sleep / wait for FW
to do something.
