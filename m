Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860852D8393
	for <linux-rt-devel@lists.linux.dev>; Sun, 10 May 2026 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444670; cv=none; b=SXNEKMYk8SHVdv9rCAnh4haEnMITGIAym8LWj3G7cYXHUIBN03NdAXBvJztbRTtvM/0alZIPARaldQ+hX7Mz37UBC3+YzE3mIao/K8bVQqOutaAzlwwEsos4F69Pdnyy0+IsuQOOSg4KMz1MNOuexjPnqkursRnOAxqg2TcSxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444670; c=relaxed/simple;
	bh=Bfc/WB8MtSNuuBFsXsab/2ISoT0JMcdHR58RLdjA2M4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td847tMgdnUWGWZclx5gV/CSyCXqVdZBAVWvyXxSKiCsEV3P3zenIbDb4Rxa457IUI2GamcFB/DEOGj4nL9nYUFxC6eN5LEoKZSCe9NwXC8Sb2hZEM1wuMUg6yr4o7cVy9oj8u5AowwxmEcZfNyewZvsN5448w6gAZ5H3JCfO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2jxPbuFy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2jxPbuFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778444669; x=1809980669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bfc/WB8MtSNuuBFsXsab/2ISoT0JMcdHR58RLdjA2M4=;
  b=2jxPbuFyt4H3EswIQqzQN1Vq/BcjO0Zrte2t8CVRy87rGREKG6WRhxqe
   cCWF5D7+1wKGEa1mD2uPle5SmEc8EoAGFrL7gY2a22tw1iay2Ph1tqbtQ
   c164QhRsFMDwtklvrgkI3PDR6A1t0DoGwFgAdqS1+G/oi7nbwkq7v/+Ue
   EfT3N6ZnUYRztzunXv2HD9/JKtRBuNOXNI4sL/DP5e0/xXJl2NlmXUq0G
   //j29xUHROGfv5FBCd/Y0BmSs+x/KyHEcX2W+DKxTw541E7SfAATnnUmf
   WQCjPmTTKWcS4cLrdaMH0SVeGROKzswGFYQG+pFphfqiT1UsewNONB2wp
   A==;
X-CSE-ConnectionGUID: VbcRMQGTQ6+eWcqm1CbgYQ==
X-CSE-MsgGUID: KIoiOUpwQPeOQIJgCqsT8A==
X-IronPort-AV: E=Sophos;i="6.23,227,1770620400"; 
   d="scan'208";a="57698493"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 May 2026 13:24:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 10 May 2026 13:24:22 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 10 May 2026 13:24:19 -0700
Date: Sun, 10 May 2026 22:24:19 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
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
Message-ID: <20260510202419.zlh3nej2ohx237by@DEN-DL-M70577.microsemi.net>
References: <20260506-misc-fixes-sparx5-lan969x-v2-0-fb236aa96908@microchip.com>
 <20260506-misc-fixes-sparx5-lan969x-v2-1-fb236aa96908@microchip.com>
 <20260507090810.53e66ef6@kernel.org>
 <20260507184714.joyobsh6ydjzrkc4@DEN-DL-M70577.microsemi.net>
 <20260508162213.6b755d8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508162213.6b755d8c@kernel.org>

> On Thu, 7 May 2026 20:47:14 +0200 Daniel Machon wrote:
> > > On Wed, 6 May 2026 09:25:36 +0200 Daniel Machon wrote:
> > > > Move the debugfs setup into a new sparx5_debugfs() helper in
> > > > sparx5_debugfs.c, invoked after sparx5_register_notifier_blocks()
> > > > succeeds so the netdev names are finalized. sparx5_vcap_init() now
> > > > only deals with VCAP state. The sparx5/ debugfs root is created in
> > > > the new helper as well.
> > >
> > > netdev names are never final :( User can change them at any time.
> > > The best practice is to name the debugfs file by some stable hw-related
> > > property, bus, port number etc.
> >
> > Right, but they are finalized in the sense that we have a name we can use for the
> > debugfs files (which we dont pre-patch).
> >
> > Hmm. I think this patch fixes an actual issue, where you cannot query the
> > debugfs files, because a previous patch broke the ordering. I agree that the
> > names chosen (netdev_name()) for the files were poor, but is that really a fix
> > for this series? Should that not be adressed in a future patch for net-next (it
> > involves changing an VCAP API function that is not only used by Sparx5/lan969x,
> > but also lan966x.).
> 
> Dunno, if we are aiming to switch to a different naming scheme we can
> just do it now, I reckon. It will not make the fix much longer.
> And presumably it will alleviate the need to reshuffle the ordering.

OK, sounds good to me. I will make the changes for v3. Thanks!

/Daniel
