Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589753314AC;
	Fri,  8 May 2026 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282535; cv=none; b=NKL+W+hBRbynAjiHNNRIJa+hKyiWXX36mtc55Qu6WIuJWaUeaTwHTXOnwf89bueBQr1QNgCGxYOYQVnhEmN1Tzo5uPGfkBEuC7TxWydZAe8o2bU8/aJf9Za3/bgit+e6GFvfLeW4o6cCxR6Gb6dOr/4UsTnefn5mhY+JgzORMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282535; c=relaxed/simple;
	bh=2AevTr3shap19RUwMMlENTSD4YYHTePzbIvM0R5o1lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCiDY0JiYI0unbWFx15mS6GTnMXm6nor8iuEG6FgPEOFAwWz8lpjatFLdUVq5+us727D+fv0A1OJvAHhQH4Zv18qn8+Ai5pIXrpuoa8qci+2FhvAAs7JRLf7u95Jfjhjq+cgWdreWQjQQh6Bu95uqzDLSd69v9eO5GKh06n4MNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U006x1Qi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U006x1Qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAAAC2BCB0;
	Fri,  8 May 2026 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282535;
	bh=2AevTr3shap19RUwMMlENTSD4YYHTePzbIvM0R5o1lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U006x1Qi5eQV8i9yrksMub0wobOaVX5RjUJq+keDQ64c+l16x5WSvWiE4KFcC/+vJ
	 roHBlJI3OkPAJJA39d2ejeHLi0IISw5fbcqZccAwDh7PRzjRDwWyeENAZvGeaMsclr
	 RPDbwOtvr6Wv2cyXplNKOlJw1UdcYSp88opgx/WQ+rpBrJ9uJSiXthYLwMtnqzR3RU
	 OCBYCis4bgVvbE1Pufq5fptFH6tEj1GmoT2/x/dMCB0lwB94aDGGR/mwMnWbWO0Ddb
	 vKU6yPeBieS4Y1flyyZjEQ8dztxlSJwdSabxUL/iJqKYO6aic98zhe8C4Kdb7VGmsM
	 J/SLZDHVmTz6w==
Date: Fri, 8 May 2026 16:22:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Bjarni Jonasson
 <bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, <kees@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net v2 1/4] net: sparx5: defer VCAP debugfs creation
 until after netdev registration
Message-ID: <20260508162213.6b755d8c@kernel.org>
In-Reply-To: <20260507184714.joyobsh6ydjzrkc4@DEN-DL-M70577.microsemi.net>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
	<20260506-misc-fixes-sparx5-lan969x-v2-1-fb236aa96908@microchip.com>
	<20260507090810.53e66ef6@kernel.org>
	<20260507184714.joyobsh6ydjzrkc4@DEN-DL-M70577.microsemi.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 20:47:14 +0200 Daniel Machon wrote:
> > On Wed, 6 May 2026 09:25:36 +0200 Daniel Machon wrote:  
> > > Move the debugfs setup into a new sparx5_debugfs() helper in
> > > sparx5_debugfs.c, invoked after sparx5_register_notifier_blocks()
> > > succeeds so the netdev names are finalized. sparx5_vcap_init() now
> > > only deals with VCAP state. The sparx5/ debugfs root is created in
> > > the new helper as well.  
> > 
> > netdev names are never final :( User can change them at any time.
> > The best practice is to name the debugfs file by some stable hw-related
> > property, bus, port number etc.  
> 
> Right, but they are finalized in the sense that we have a name we can use for the
> debugfs files (which we dont pre-patch).
> 
> Hmm. I think this patch fixes an actual issue, where you cannot query the
> debugfs files, because a previous patch broke the ordering. I agree that the
> names chosen (netdev_name()) for the files were poor, but is that really a fix
> for this series? Should that not be adressed in a future patch for net-next (it
> involves changing an VCAP API function that is not only used by Sparx5/lan969x,
> but also lan966x.).

Dunno, if we are aiming to switch to a different naming scheme we can
just do it now, I reckon. It will not make the fix much longer.
And presumably it will alleviate the need to reshuffle the ordering.
