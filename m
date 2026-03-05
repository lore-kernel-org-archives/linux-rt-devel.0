Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5E3644CC
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Mar 2026 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752147; cv=none; b=GXsJQ2E+rLaGkXrpf9OpgBy8fGXt5LXMd4NUCtrfvWu6/gpFCF2WzT72OfreRSPv7k8IJTBJK3p7BED9QeksZP1WPGFIwqQe4XYsTtwo75wPXspMszYFW4VuUsD5w4z943vW7p5oXuq+1xdNhAO5mag5dd51tDfl4q+50FzaCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752147; c=relaxed/simple;
	bh=cRBXowwMx8f+4eUc6cscyBmZz4ZjEsdQxTE+c+eax9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehVq1+SNYR9nJypEHJKZ+YdBeI7HsvqdtyCJNkqHRWEl5tiTNKjEwaSNBLsnaLDftO9Hv4KevPaxT33uVkqVDS+Qq45hDSMm5uXUjCTJyUxDt2nP0HbXnt6kqHuHVSMQN5W5ynHO1+LLzvI3EHSIuosgEcHi/Bh4KEB6V0cU9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2574B57F1F;
	Thu,  5 Mar 2026 23:09:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id E870320029;
	Thu,  5 Mar 2026 23:09:02 +0000 (UTC)
Date: Thu, 5 Mar 2026 18:09:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Jonathan Corbet
 <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Derek
 Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <20260305180902.300fece5@gandalf.local.home>
In-Reply-To: <aanwC228bGTa38LK@casper.infradead.org>
References: <20260305205023.361530-1-darwi@linutronix.de>
	<20260305205023.361530-2-darwi@linutronix.de>
	<aanwC228bGTa38LK@casper.infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E870320029
X-Rspamd-Server: rspamout06
X-Stat-Signature: y61g89knifynbjocw11ks4186nt7y7k9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+WRo6Tr1qE0GLKBnPRl01fQ2wfyP5ThFU=
X-HE-Tag: 1772752142-441956
X-HE-Meta: U2FsdGVkX1+fTAj5vA+b77zBDGTIcr/NDhHbaVWe2jadqVUvMCH1+xrdMNB7LN1Q7T+1Y1/lY/1mDWQZ7m42jKrzpgvJX8GhRjFFuCjawN3U2VAJglCv2mjKs6uRlX99yZpSfIiqpBHOi5hSkqrrR5MoiL2aOL+Jmlrz1Qf6anPe7qlsh9ER07+NkdG0N44ZdATKPKfNwA73LMJ2kefyCcDRgXcF69OuZAOU9bpwvWT815I/Xfjqr3tzNVRuGg3DsIm2+O5nBopCgjO7bhMZ8/tVdkjtNmRThQXFEIyffcoAC9TB1FKv8Q1sJY4wIUD/Eun/YSdPuWIWaUOqyXzoW8NNM7PT5q5xNtn8rBlzh78G3dyeQAd2/nmiMTvjw5fs1p44ewjpvk8ryVpwrXByRQ==

On Thu, 5 Mar 2026 21:05:15 +0000
Matthew Wilcox <willy@infradead.org> wrote:

> > +With that in mind, any false real-time kernel configuration could cause a  
> 
> incorrect rather than false, perhaps?

Heh, I just read this now after making the same comment.

-- Steve
