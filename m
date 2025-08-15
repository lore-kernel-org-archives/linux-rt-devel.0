Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90186275B09
	for <linux-rt-devel@lists.linux.dev>; Fri, 15 Aug 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266283; cv=none; b=Y+Jzf80bt43uYLo1JfC7H8B1u/T78j5SFwfi0StcUkIoNbMQmg6aQ4iIeg6KmEORTKf+HXceKxjDTibrsCRyVHjbpg5xlIxIqqgbreeEp/pNnaSZQNXOyghyd57NITkgej7uGS2oR133RPXvmYjpkPOzHr1jZf/R87tq0ssBkTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266283; c=relaxed/simple;
	bh=3i2XwEiUWtcY9tVi2Jo9ocqkzPo9A5lYI1mOmRJOiDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qZua8NEBlvffBv6+Z1heW6ppS2CAhm1Q/59+jrtvba4LxnuHg0pJCgH7oZxbt2YKy3bjYX3Jt5982AQgQUNNkyQdqhXO6ep6NoO7o1fnZhLmWEN821l5OAR2gynh5Qy/XL37zi8iNpdYmMpa+Oqb3MUegZEUt25rVg+g7Sv00Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZAYDx33I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=slhFL3Vu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZAYDx33I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="slhFL3Vu"
Date: Fri, 15 Aug 2025 15:57:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755266279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nyvcUS+/2o+Fhop1KJaZB0aAOwF9swOXW+69NmOfClc=;
	b=ZAYDx33IOxlrrz+Nw3yhp/YSiYN8FJKNWJKnana9cSzTQEjlfIF/CENaK67cJcTAqEbiCz
	6rKX5F1y4gg/LZbn+GM6S2S+ugjEx0L3OgVtA7FEC21dpIPfyut/KAqOJT7uJijltQrFni
	J1kcSmtUJqtEd2G0UY53qIjqsk4hmNeCpb41He4vDo6UrRJgdkUgXvK/HZEZJAGZX+l7xQ
	t4qaIEs7mai57tl0HZkEmixEEVPvSlVlRTdydzvg0Qf1eSvazTCOTUOoKYo6iYrTXthjRF
	2Uhm4VBICAe+roWMe2/7txnMgkIe1keZhYsyhSL6E7sHtRdL8yTWoZTQx1zIlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755266279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nyvcUS+/2o+Fhop1KJaZB0aAOwF9swOXW+69NmOfClc=;
	b=slhFL3VuCt4g9zI2YeoqB9lFcLN34mH6MNprjUqIJ2F221NqdlfO5tBqkln3XXKa+zoWHD
	RMtwCCdOEvhc6vAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.17-rc1-rt1
Message-ID: <20250815135757.yZK2felP@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.17-rc1-rt1 patch set. 

Changes since v6.16-rt3

  - Updatet to v6.17-rc1

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.17-rc1-rt1

The RT patch against v6.17-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patch-6.17-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.17/older/patches-6.17-rc1-rt1.tar.xz

Sebastian
