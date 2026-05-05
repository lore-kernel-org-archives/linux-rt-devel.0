Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A42C15AA
	for <linux-rt-devel@lists.linux.dev>; Tue,  5 May 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007078; cv=none; b=CTEn74WaK3JWbyiomOT8wy49fwmZUnJ0XWni5gFNYjYgGaRqioMaH5+dk4hNGh1MWdNm4UkxpnT/vUSKd891ns9C0cymOofQeLyYrqTFQPhZL3YOxvNoCWVpa3Tdi2lt3DxVnxHaPVJgqupqSsx8VvKjlIGiMnkGaib4egHqbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007078; c=relaxed/simple;
	bh=VDJOXjgjZEbpeB4zDJMcjcuhMeExkg7wy+dT+dQlbbQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6EegSirkEXaM9MzsKiEWr/Qn/oTv0qf4AKFZS+cCiHv+K7jg1ZP3OyZDrd6kth+45YmIMbQlBlQjuLkyhUS2tefIcOY3mogim2Dr8sz6n2tv7wDo2odz0l8qSey/4mYJuMoisa5C2kXvrINT9Lom8tvghqTuIaQQykbm2X/5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zTsGGisz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zTsGGisz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778007076; x=1809543076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VDJOXjgjZEbpeB4zDJMcjcuhMeExkg7wy+dT+dQlbbQ=;
  b=zTsGGiszdw84ec11fku3ABDHCBeAvie8y4DpKUwWJ3xVt7qrzKYYaY6Q
   f6NLxPo1xGmomRVVZPMdE/olXNqnQnAPj83suMVRXVHqhbIH2eRjPpvyA
   FiMAWZ/ZUyhPFVdtwbBL5aHc/+MykfAswIRTGfzxQtuXGkMxjlqJxu7+M
   4f8sbHIidW8cddWe425IsFHHDgcA+A/+4nXFCxciO9DUtrHsdv8xH9ATr
   neQFL4T6mUzioCO6NSou1dBBGP0ZYTUDwuDaXWb4oZI6Iq36WIBX3Y4ff
   qVqY+L/gepVZOyqJ1V2OYUvHYbf9vT8KYAFLlnNjcG4WRZxFjyVo9HnoX
   w==;
X-CSE-ConnectionGUID: rdJ3Lq+USdyRShk3O56huA==
X-CSE-MsgGUID: 8Vitu6v3QSSCz52QCXNVpw==
X-IronPort-AV: E=Sophos;i="6.23,218,1770620400"; 
   d="scan'208";a="56297656"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 May 2026 11:51:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 5 May 2026 11:51:08 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 5 May 2026 11:51:05 -0700
Date: Tue, 5 May 2026 20:51:05 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH net 2/4] net: sparx5: fix sleep in atomic context in MAC
 table access
Message-ID: <20260505185105.c7bcupjgm64vcrhy@DEN-DL-M70577.microsemi.net>
References: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
 <20260504-misc-fixes-sparx5-lan969x-v1-2-6604306b5743@microchip.com>
 <20260504165258.30b81158@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260504165258.30b81158@kernel.org>

> On Mon, 4 May 2026 16:43:43 +0200 Daniel Machon wrote:
> > sparx5_mact_learn() is called from .ndo_set_rx_mode with
> > netif_addr_lock_bh held, but takes sparx5->lock which is a mutex.
> > A mutex may block, which is not allowed from atomic context.
> 
> Could you try to switch to the recently added ndo_set_rx_mode_async?
> We added it exactly because most drivers have to sleep / wait for FW
> to do something.

Interesting. That should get rid of the spinlock and readx_poll_timeout_atomic
conversions. I will try it out. Thanks.

/Daniel
