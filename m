Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B42283FCE;
	Thu,  7 May 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170092; cv=none; b=g1S5zNINkDESHSfJi/iPaAZIJ7plKtPHhZ/sc5mpTM1cr2isuSDLFY5H+oCR9dvi4PRabK8r6erD2bGLi5bmcmgk2OovugapIULk10Ib6vflWi5cQ3Xy6kz8QP9QDp9a8jlgLX9JLCUQxu3AHJMkwsKP+NApbgIHjgXhExVmKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170092; c=relaxed/simple;
	bh=rdy5PtRz/HkDIo5L6Ua+6U739iTp3/ZnRsbhHuHjN8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlUaBzsvsuOTHNvnpXQ9dJ5XW5zT5RJrYmnkf0PVJliclVw8iPII0iz5gpA6bOASwizC3ECkwzA1kJMw5frh1Bxx/lCoFdPjSwKFaKrh9+NdiMPRdyVfcUrLnOsKyoiHgpr1mJ8zj4VmnLUUtW8gxnm3Xf3I2IjlX45kN9J++uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXrsRXuK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXrsRXuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032ABC2BCB2;
	Thu,  7 May 2026 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170091;
	bh=rdy5PtRz/HkDIo5L6Ua+6U739iTp3/ZnRsbhHuHjN8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZXrsRXuKTrmWAAJUa/ZIgyYSyMYUwzsrAWEGTT9WgtinnjihNNt5J1INMOcC5Tlem
	 8gOuJNJ7PQHkv0Srns0u6bacUCy6qOnXpPznj6aJvQ2HiBEM7xB82cIFNkKOlVKLG0
	 QXSaW964r2JHVTGrZROhhEviR+vhEMrhsQbC2CxSj43S8k9zj6APVJK2K2qAoG3nsI
	 kROWk7pxQXJ/t8LyEWDRCsK5mKEmVRfytDKhjmLKOH1PBe9LkiM1Wo8dsiRhKEmxHS
	 Qx3cK4tJQHi8yFgf/j2nr7C9nJoQVpdoA4BpMuSpkYH77ZeG+Q44AijNGPS1kacAt1
	 rR2rJz7j26lWw==
Date: Thu, 7 May 2026 09:08:10 -0700
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
 <linux-arm-kernel@lists.infradead.org>, <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net v2 1/4] net: sparx5: defer VCAP debugfs creation
 until after netdev registration
Message-ID: <20260507090810.53e66ef6@kernel.org>
In-Reply-To: <20260506-misc-fixes-sparx5-lan969x-v2-1-fb236aa96908@microchip.com>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
	<20260506-misc-fixes-sparx5-lan969x-v2-1-fb236aa96908@microchip.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 09:25:36 +0200 Daniel Machon wrote:
> Move the debugfs setup into a new sparx5_debugfs() helper in
> sparx5_debugfs.c, invoked after sparx5_register_notifier_blocks()
> succeeds so the netdev names are finalized. sparx5_vcap_init() now
> only deals with VCAP state. The sparx5/ debugfs root is created in
> the new helper as well.

netdev names are never final :( User can change them at any time.
The best practice is to name the debugfs file by some stable hw-related
property, bus, port number etc.
