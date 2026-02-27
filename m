Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353443E49A
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205521; cv=none; b=cD+a6608yw+LBDTO6SazVpzB0UqTfl0MguRKIlJvxtX4qqoKqgl8Fb3r9bzjYiWD5TtXmVIJTOd/g+O/XoG852mhNCjzOQ49i+WbriT2gQjUY7cBlIh/ghAFtGs7Re6lawmQ3G/LgqFwdxYlTml65aViBgyFr/gvSxhKhnmzyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205521; c=relaxed/simple;
	bh=UBkZpRH2/PRrgsQH+oZrQQicn9h7cymmIyro/uVLHn4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DBVJz3Bgc5Sggg9hgaCi9ZtZaopV38Yg8jUyQGk1YuiBh9dQAVQLPJnZ3RBolthLbTRTHtcigDl4Svqd+xaME4RjlZLlXVb/5OrGBJl4O7sgcoC4qFnlpmIIfpSZDQqZZKn1jcwPlsx95lq3CJqdqGZaP19p4BG2ZRAg8mKhGVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c19yThi8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c19yThi8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t1Hf6lOuL/RzLUoGC5aThpJ+W9Ml69mlfHZtXwUlafo=; b=c19yThi8C41VK49OhNEt4zZh2t
	gxjN48N5E77P5B0WUpt/kXA/oU2L9FgMFGF+vARxd88aQW0SpWbOmDY1m0dYLcrj59RohjCHTZtsV
	TDplukBgAlv2a5RFBjwxOaqpfva+CQPCDYKzSCgp86CUEr5Y2IwbqJHFG8CrObN6S7TuGwZOKHkhe
	2M/JBUhMesJR+dptfKUoO9E8a+9MElu8OPrhUiD9NKZ8Wk80TqZNTfwHZKOGwqU8XkyEBxEH8J+RL
	kjCO/uud8t29J8n38FRXKTHrDm+N0KQkJmt/SaIde/ipFC/KFd7VE5T/+PJHuLlagylNO5YGS/Yys
	H0GhWMRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42646)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vvzbo-000000000xd-2JuX;
	Fri, 27 Feb 2026 15:18:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vvzbm-000000003Av-0msw;
	Fri, 27 Feb 2026 15:18:26 +0000
Date: Fri, 27 Feb 2026 15:18:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Cc: Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/6] ARM: cleanup fault handling
Message-ID: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series cleans up the 32-bit ARM fault handling:

1. ensure a consistent IRQ state in the user fault processing path.
2. split vmalloc fault processing in a similar way to x86
3. move is_..._fault() to the local fault.h header file
4. update the FSR deifnitions using BIT() and GENMASK()
5. move LPAE/non-LPAE specific FSR bits/masks along side users
6. get rid of #ifdefs within is_..._fault() by providing a LPAE
   and non-LPAE versions.

 arch/arm/mm/fault.c | 158 ++++++++++++++++++++++++----------------------------
 arch/arm/mm/fault.h |  42 ++++++++++++--
 2 files changed, 109 insertions(+), 91 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
