Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2FF70823
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Jun 2025 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750730964; cv=none; b=KIFyy+3BEtKz5Q9UFsaeAzchCU58a5rCqnSJqHuhlqEL6m5OQpciZm174w1RigynROlGjIlR/Vgb1WHiI59DAgbgfC50g88FRBYR2W5fjLPKYVyKWeTnbETTFetHOIh2LMqDo82TZkeeDyprMl2SXUUpTt9YB65HdyMvy0gkfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750730964; c=relaxed/simple;
	bh=JgEkOC4t36OllD63xgaWDC+Skqixr58oiJngBBFa+gM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TbLHix9vTBsPNxv/5xlS333ASa3Uk+8IvgkeVim4vzSWjUF0o6A8JuEd8V/rHSxXcP62ka7Hn0POKrMzM6oD/F2jXZpfpUzdyD9WFCRbiZufFZN/E+ryGhfwvPiYDiuqJvvDiOp4hl2Uo0YSkxFwVMZYVjRWIVTXxZd1Ji0LMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0DF7692009C; Tue, 24 Jun 2025 04:09:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0690092009B;
	Tue, 24 Jun 2025 03:09:14 +0100 (BST)
Date: Tue, 24 Jun 2025 03:09:14 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Palmer Dabbelt <palmer@dabbelt.com>
cc: namcao@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>, 
    aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>, 
    bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
    linux-rt-devel@lists.linux.dev, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
In-Reply-To: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
Message-ID: <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 23 Jun 2025, Palmer Dabbelt wrote:

> I'm kind of split on a Fixes tag here.  One could argue it's a regression, as
> having interrupts disabled during exceptions is going to cause all sorts of
> performance issues for users.  Seems a bit risk to just backport, though...
> 
> That said, if nobody noticed then it's probably a good sign nobody is really
> paying attention and we should just backport it before anyone notices...

 Oh, someone did notice and it's not only performance, cf. 
<https://lore.kernel.org/r/alpine.DEB.2.21.2501070143250.18889@angie.orcam.me.uk/>.

  Maciej
