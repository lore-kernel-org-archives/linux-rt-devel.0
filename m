Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796204A06;
	Wed, 23 Apr 2025 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745374555; cv=none; b=QUeKCIKLLl99gKzr76H6tKMEusIkz2myW4DG5k9umMtSoaGufFSxTbS4QMn3NMqkv6CYyKEwZIvp3/keC3iTNgf/75mdIbucfHiPUIjao0i2/Z1jQWN9EQ5jcOJTFtnlfQlw/S5INNqErZm6wQJSOWBq9NaAYRSl90Bu6lcCsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745374555; c=relaxed/simple;
	bh=uMWRC0mX21CCnzoFN25e4PYINhMXPjtIdAYTkYHgev4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHBF/chvm03utA5i86UJs6FKdspmZWnO5Zs90avdrI5rBXqEIUxkXBmM0EuTQ0J6KLmog6MnyXBJBKzfkr0Wop+TV9WGLwtdpVQoNYM92lBxozUbpS0JaOOLWEQLRXPkK9Ow42wiJ1LrbnuKQ2l6U/XbhHEAIukO/4nuqH5qwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S0S5x0ux; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S0S5x0ux"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3E/Nw19u36SXEMrl+EhZ1FRQFD9W6ajpHgqUEXxizb8=; b=S0S5x0ux1kKNgFqxHa37bpq5DH
	t2kAWHYs0Wr4cRxjnXBQjojyDP0uxgDGjGguxb7qVmZvq9upz2sbRsm9iwmJkJA3mykWZ3UWdsU3W
	3AtvLxKB7kLYMjC7IrYhFh9HyVxqaHdzS4+KDIAtqBsBSXJffYAcQSQtAZM84RWwTMXsrnaRzdzae
	R1qhPAtCGgP4UL12L5oNubyBORGX5T5zsImb+tjTbKlO4kwByUWrmEhztdz8t6v4EzYvozF8hallV
	WnfmEpd8ZP749kgRP1nnM1x8Gv3Nu/XEXm3YnoPE+ZNSPd18RPEGV67evLTBfwI24Gy95JMEg+A+Y
	Ys61pPxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7PeN-00000008IT2-44KK;
	Wed, 23 Apr 2025 02:15:48 +0000
Date: Wed, 23 Apr 2025 03:15:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Chanudet <echanude@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Alexander Larsson <alexl@redhat.com>,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <20250423021547.GD2023217@ZenIV>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250420055406.GS2023217@ZenIV>
 <fzqxqmlhild55m7lfrcdjikkuapi3hzulyt66d6xqdfhz3gjft@cimjdcqdc62n>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fzqxqmlhild55m7lfrcdjikkuapi3hzulyt66d6xqdfhz3gjft@cimjdcqdc62n>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 22, 2025 at 03:53:43PM -0400, Eric Chanudet wrote:

> I'm not quite following. With umount -l, I thought there is no guaranty
> that the file-system is shutdown. Doesn't "shutdown -r now" already
> risks loses without any of these changes today?

Busy filesystems might stay around after umount -l, for as long as they
are busy.  I.e. if there's a process with cwd on one of the affected
filesystems, it will remain active until that process chdirs away or
gets killed, etc.  Assuming that your userland kills all processes before
rebooting the kernel, everything ought to be shut down, TYVM...

If not for that, the damn thing would be impossible to use safely...
