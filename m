Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65E03793D2
	for <linux-rt-devel@lists.linux.dev>; Wed, 13 May 2026 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704952; cv=none; b=drO+ZYVYtnHc4p4J+mJi/saD+2uQDDdGxmD826q8PtcDov6RtBmkFAPNO2TZl5WApYj0/tI0xAGFUXbGgXAaIryh/xXTZxAeyZK1QLwsT3s/5DSI7Rwm9+dz1Ehi3FERc+Aqa1xzh4mwV9XnBcs5dKeLEGiZThDbyU8ICHR3LRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704952; c=relaxed/simple;
	bh=nsVKqqsfnEmyfNnY4L0GBoylantpmY83DLlLD29WGXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyE7cS7ISLotFgsZKpvhqD125MqIN+CjeevG9/gknzhVpt3aWA9UKeopEuAgTWudiRGVl/+dwnQmU5GVIIA4tF6+CCZeiZts+mNwT058GZRwTAlZnw6tZME/4H5L7JzC89HRB8qx8UCmE2vGHTB0SzR+mN6n+IZPJ7KZE36pRx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VQYigv79; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UoDWNId7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VQYigv79";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoDWNId7"
Date: Wed, 13 May 2026 22:42:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778704947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsVKqqsfnEmyfNnY4L0GBoylantpmY83DLlLD29WGXM=;
	b=VQYigv79l9qdOLy5DxZc7WM9od41wtFGt6AZZAlylLhZ5CZIXZiJ0l/86dNopZl1eWfyPB
	QntpsCOQwDXnA/jLdXNHo06zxyN2upFgFkGedeym4m+1UD0X64On+SSwRLVtas+MZk8CLj
	W6GJ/F2hm0uV858qZIzqsWvJPqofpomtzNMKVTp/xMidK3RYrk9ggNgteOPWmbpWYYFa3y
	Frthcmle7/mmIsLRNOWJzzKekq+2cY8F+wDTdAafisHbRJKWJJ/XiKIpPIBoTLguVg5tAR
	91QbV2+5Z7w2FHVZnnmaz8YWlqkUNv+I4RX6ZsSCRlw/sRMYw1DLmQ0mmrZvyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778704947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nsVKqqsfnEmyfNnY4L0GBoylantpmY83DLlLD29WGXM=;
	b=UoDWNId7/WQvMDj0LUfLeQnkyguO6ljgPniAx6Z/GdDMtazzHG0vEZymy2XsdPGVWJGBtF
	FaejJ7uamOpzFEDA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Cc: Matthew Wilcox <willy@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <agTiMfsnt-m9r_mH@lx-t490>
References: <20260414174159.1271171-1-darwi@linutronix.de>
 <20260414174159.1271171-2-darwi@linutronix.de>
 <ad5_XCnVDlC9Hvup@lx-t490>
 <ad6DcliisiRxw5RN@lx-t490>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6DcliisiRxw5RN@lx-t490>

On Tue, 14 Apr 2026, Ahmed S. Darwish wrote:
>
> Add a configuration guide for real-time kernels.
>

Kind reminder.
