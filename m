Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8582288CB;
	Thu,  7 May 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170214; cv=none; b=UuFyGxyJnu2Zo4cqWOWJbggltxc7XemJHBqnn+8RclW3w0jzZYbJXVZblVFwPBC2GWx/T9l4vbTjPKpQxQQJYpk7hXV+3Q4vCEP5lZVlIjhiRUWCk979iATCAPZk1vi4ZJDaUTaz4IGMRYl7p7SQmzcrP/UNxFOL1KNvMctFUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170214; c=relaxed/simple;
	bh=fxwf3I7h7jhgXQ9lw8NOcAt3++3EMEiDRO+U9K4nGPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdtEGukPvb9iOZQ7lgmSebRADSUHD6FEnC5m/mTOfBfSK9Bqn73VVC9pHWIXrpV11UV7kQtax9v3KJSvQKq0NL7lxnv4GtawaKj4Y0CSqkVVwNoD6FOIZBq9b7chwlQ8h++UZY6WTqsNi3oNrFpspTCGcYEvAPhi/nOzg9voFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCuMcWr9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCuMcWr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DA5C2BCB2;
	Thu,  7 May 2026 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170214;
	bh=fxwf3I7h7jhgXQ9lw8NOcAt3++3EMEiDRO+U9K4nGPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uCuMcWr9E0ZYLfq7TWoM2JB4UuCJ5bmGDp0CgS8YV6u1Fu0kGSIeqXuQ+gVHco7Yh
	 zCswGy+R6KX6gxhvA1t8Q7c59bspjQE2GEETMR7FN9xMOXyqgfD3OTEhn7WRAikeFz
	 EC7RaHAG3XRcRMCf5VuwHJUTYism9BYK94Jdwit95i01F0BVQWJuLqjVQYFr1n5sZl
	 B5TkDpQz9BHM0Rpo0gR0IfFVcdnBI4NiLJkMnsg56gBUZmpKy6vAARBhOvfFNlgMhu
	 dEw12El0DxT3k8NKYtbojeCWFp/dpFPqO8zc7d/ijxCMyDylN6kGvHu9xwpqrRTQFE
	 EFbSf7FyaNXpg==
Date: Thu, 7 May 2026 09:10:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 <UNGLinuxDriver@microchip.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
 <bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v2 0/4] net: sparx5: misc fixes for sparx5 and
 lan969x
Message-ID: <20260507091012.7eeb17f5@kernel.org>
In-Reply-To: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 09:25:35 +0200 Daniel Machon wrote:
>       net: sparx5: fix wrong chip ids for TSN SKUs
>       net: sparx5: configure serdes for 1000BASE-X in sparx5_port_init()

Let me grab these two already. patch 1 I think needs more work,
patch 2 is probably fine but maybe we should address the sashiko
issue in the same series
